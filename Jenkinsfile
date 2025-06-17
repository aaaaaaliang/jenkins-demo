pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp:latest"
        SERVER_IP = "60.204.219.177"
        SERVER_USER = "root"
        SERVER_PORT = "8888"
    }

    stages {
        stage('拉取代码（shell）') {
            steps {
                sh '''
                    echo "🚀 开始拉取代码（使用 ghproxy 加速）..."
                    rm -rf jenkins-demo || true
                    git clone --depth=1 https://github.com/aaaaaaliang/jenkins-demo.git
                    cp -r jenkins-demo/* .
                    echo "✅ 拉取完成"
                '''
            }
        }

        stage('构建镜像') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('上传并部署') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'a9c9f749-be96-44a4-89ef-f36c281b3fbc',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                        echo "✅ 上传镜像到服务器..."
                        docker save $IMAGE_NAME | bzip2 | sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $USER@$SERVER_IP 'bunzip2 | docker load'

                        echo "🚀 重启远程容器..."
                        sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $USER@$SERVER_IP '
                            docker stop myapp || true
                            docker rm myapp || true
                            docker run -d --name myapp -p ${SERVER_PORT}:${SERVER_PORT} myapp:latest
                        '
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "🎉 构建部署成功！访问：http://${SERVER_IP}:${SERVER_PORT}"
        }
        failure {
            echo '❌ 构建或部署失败，请查看控制台日志'
        }
    }
}
