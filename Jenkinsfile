pipeline {
    agent any
    environment {
        IMAGEN_DOCKER = 'mi-sitio-react:latest'
    }
    stages {
        stage('Extracción de Código') {
            steps {
                checkout scm
            }
        }
        stage('Compilación del Contenedor') {
            steps {
                sh 'docker build -t ${IMAGEN_DOCKER} .'
            }
        }
        stage('Despliegue Automático') {
            steps {
                sh 'docker stop mi-sitio-react-test || true'
                sh 'docker rm mi-sitio-react-test || true'
                sh 'docker run -d -p 8081:80 --name mi-sitio-react-test ${IMAGEN_DOCKER}'
            }
        }
    }
}
