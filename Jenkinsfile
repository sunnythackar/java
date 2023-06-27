pipeline {
    agent {label 'master'}
    tools {
        maven 'MAVEN_HOME'
        jdk 'JAVA'
        git 'Default'
        nodejs 'node_js'
        //sonarqube 'sonar-scanner'
    }
    environment {
        currentDate = sh(returnStdout: true, script: 'date +%Y%m%d.%H%M%S').trim()
    }
    stages{
        stage("./waconsumersurvey"){
            steps{
                sh "rm -rf waconsumersurvey"
                sh "git clone git@bitbucket.org:m-gupta/waconsumersurvey.git -b ${branch_name}"
                dir("waconsumersurvey/"){
                //sh "mvn clean package"
                }
            }
        }
        stage("Docker Build") {
            steps {
                script{
                    sh "aws ecr get-login-password --region us-east-1 --profile test-jenkins | docker login --username AWS --password-stdin 738448646260.dkr.ecr.us-east-1.amazonaws.com"
                    sh "docker build -f waconsumersurvey-pipeline/Dockerfile -t waconsumersurvey ."
                    sh "docker tag waconsumersurvey:latest 738448646260.dkr.ecr.us-east-1.amazonaws.com/waconsumersurvey:${env.branch_name}-${BUILD_NUMBER}-date-${currentDate}"
                    sh "docker push 738448646260.dkr.ecr.us-east-1.amazonaws.com/waconsumersurvey:${env.branch_name}-${BUILD_NUMBER}-date-${currentDate}"
                }
            }
        }
        stage("Helm Deployment") {
            steps {
               script{
                sh "pwd"
                sh "ls -la"
                dir("./waconsumersurvey-pipeline/") {
                    sh "sed -i -e 's/name:.*/name: waconsumersurvey/' charts/Chart.yaml"
                    sh "sed -i -e 's/version:.*/version: 1.1.$BUILD_NUMBER/' charts/Chart.yaml"
                    sh "sed -i -e 's/appVersion:.*/appVersion: 1.1.$BUILD_NUMBER/' charts/Chart.yaml"
                    sh "sed -i -e 's/tag: .*/tag: ${env.branch_name}-${BUILD_NUMBER}-date-${currentDate}/' charts/values.yaml"
                    sh "export PATH=$PATH:$HOME/bin"
                    sh "helm upgrade --install waconsumersurvey charts -f charts/values.yaml --kubeconfig=/home/jenkins/.kube/config"
                }
                }
            }
        }
}
}
