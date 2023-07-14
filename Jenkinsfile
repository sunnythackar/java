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
                sh "git clone https://m-gupta:qWcDe6aGCTq7vNBy8hNV@bitbucket.org/m-gupta/waconsumersurvey.git -b ${branch_name}"
                dir("waconsumersurvey/"){
                //sh "mvn clean package"
                }
            }
        }
        stage("Docker Build") {
            steps {
                script{
                    sh "aws ecr get-login-password --region us-east-1 --profile test-jenkins | docker login --username AWS --password-stdin 738448646260.dkr.ecr.us-east-1.amazonaws.com"
                    sh "docker build -t test ."
                    sh "docker tag test:latest 738448646260.dkr.ecr.us-east-1.amazonaws.com/test:latest:${env.branch_name}-${BUILD_NUMBER}-date-${currentDate}"
                    sh "docker push 738448646260.dkr.ecr.us-east-1.amazonaws.com/test:latest:${env.branch_name}-${BUILD_NUMBER}-date-${currentDate}"
                }
            }
        }
}
}
