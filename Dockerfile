FROM nginx:latest

# 复制启动脚本
COPY entrypoint.sh /usr/bin/entrypoint.sh

# 可选：复制默认证书文件（如果有）
COPY certs /etc/nginx/certs

# 设置工作目录
WORKDIR /etc/nginx

# 替换入口点为动态脚本
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
