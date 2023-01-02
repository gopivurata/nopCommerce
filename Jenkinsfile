pipeline {
	agent {label 'docker'}
    stages {
        stage ('git clone') {
            steps {
                git branch: 'develop', 
                    url: 'https://github.com/gopivurata/nopCommerce.git'
            }
        }
        stage ('docker image build') {
            steps {
                sh 'docker image build -t nopcommerce:2.0 .'
                sh 'docker image tag nopcommerce:2.0 gopivurata/nopcommerce:2.0'
                sh 'docker image push gopivurata/nopcommerce:2.0'
            }
        }
        stage ('eks cluster') {
            agent {label 'terraform'}
            steps {
                git branch: 'main', 
                    url: 'https://github.com/gopivurata/learn-terraform-provision-eks-cluster.git'
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
                sh 'aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)'
            }
        }
    }
}