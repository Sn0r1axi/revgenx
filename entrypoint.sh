#!/bin/bash

# 默认值
PROXY_PASS=${PROXY_PASS:-"http://127.0.0.1:8080"}
LISTEN_PORT=${LISTEN_PORT:-80}
SERVER_NAME=${SERVER_NAME:-"localhost"}
ENABLE_SSL=${ENABLE_SSL:-false}
SSL_CERT_PATH=${SSL_CERT_PATH:-"/etc/nginx/certs/cert.pem"}
SSL_KEY_PATH=${SSL_KEY_PATH:-"/etc/nginx/certs/key.pem"}

# 配置文件路径
NGINX_CONF="/etc/nginx/nginx.conf"

# 根据环境变量生成 Nginx 配置
cat > $NGINX_CONF <<EOL
events {
    worker_connections 1024;
}

http {
    server {
        listen ${LISTEN_PORT};
EOL

if [ "$ENABLE_SSL" = "true" ]; then
    cat >> $NGINX_CONF <<EOL
        listen 443 ssl;
        ssl_certificate ${SSL_CERT_PATH};
        ssl_certificate_key ${SSL_KEY_PATH};
EOL
fi

cat >> $NGINX_CONF <<EOL
        server_name ${SERVER_NAME};

        location / {
            proxy_pass ${PROXY_PASS};
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
}
EOL

# 启动 Nginx
nginx -g "daemon off;"
