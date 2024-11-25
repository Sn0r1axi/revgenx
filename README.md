这是一个用于通过nginx快速建立反向代理的一个docker项目

#### 1. 准备证书
在项目目录下创建 `certs` 文件夹，放入 SSL 证书和密钥文件：

```bash
mkdir certs
# 放入 cert.pem 和 key.pem 文件
```

#### 2. 构建镜像
在包含 `Dockerfile` 的目录下构建动态 Nginx 镜像：

```bash
docker build -t dynamic-nginx .
```

#### 3. 启动服务
运行以下命令启动容器：

```bash
docker-compose up -d
```