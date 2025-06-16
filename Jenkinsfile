pipeline {
    agent any

    stages {
        stage('拉取代码') {
            steps {
                echo '拉取代码完成'
            }
        }

        stage('构建') {
            steps {
                echo '开始构建项目...'
                // 示例：假如是 Go 项目
                // sh 'go build -v -o main main.go'
            }
        }

        stage('测试') {
            steps {
                echo '运行测试用例...123'
                // sh 'go test ./...'
            }
        }

        stage('部署') {
            steps {
                echo '部署逻辑...'
            }
        }
    }
}
