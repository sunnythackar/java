pipeline {
    agent {label 'test'}
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
