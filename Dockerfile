# 使用官方 Node.js 镜像作为构建环境
FROM node:16 AS build

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器
COPY . .

# 安装依赖并构建项目
RUN npm install && npm run build

# 使用官方 Nginx 镜像作为运行环境
FROM nginx:alpine

# 将构建后的文件复制到 Nginx 的默认静态文件目录
COPY --from=build /app/dist /usr/share/nginx/html

# 复制自定义 Nginx 配置文件
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# 暴露 Nginx 默认端口
EXPOSE 8080

# 启动 Nginx 服务
CMD ["nginx", "-g", "daemon off;"]
