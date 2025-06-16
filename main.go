package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	// 创建 Gin 路由器
	r := gin.Default()

	// 加载 templates 目录下的 HTML 文件
	r.LoadHTMLGlob("templates/*")

	// 定义根路由
	r.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.html", gin.H{
			"title": "欢迎访问 Jenkins + Go 示例项目",
		})
	})

	// 启动服务器，监听 8080
	r.Run(":8888")
}
