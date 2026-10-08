pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t myapp:v2 .'
            }
        }
        stage('Deploy Green') {
            steps {
                sh '''
                # Dynamically find the active minikube port and update kubectl config
                export API_PORT=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}' | awk -F: '{print $3}' | tr -d '/')
                echo "Current active Minikube port: $API_PORT"
                
                kubectl config set-cluster minikube --server=https://127.0.0.1:$API_PORT
                kubectl apply --validate=false -f deployment-green.yaml
                '''
            }
        }
        stage('Switch Traffic') {
            steps {
                input "Switch traffic from Blue to Green?"
                sh '''
                kubectl patch service myapp-service \
                -p '{"spec":{"selector":{"app":"myapp","color":"green"}}}'
                '''
            }
        }
    }
}
