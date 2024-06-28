FROM postgres:14.6
# 更换国内源
RUN sed -i "s|http://.*.debian.org/debian|http://mirror.sjtu.edu.cn/debian|g" /etc/apt/sources.list && \
    apt-get update 
# 安装插件
RUN apt-get install -y --no-install-recommends ca-certificates wget && \
    wget -qO - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add - && \
    echo "deb https://packagecloud.io/timescale/timescaledb/ubuntu/ focal main" > /etc/apt/sources.list.d/timescaledb.list && \
    apt-get update && \
    apt-get install -y timescaledb-2-oss-postgresql-14 && \
    apt-get install -y postgis && \
    apt-get install -y postgresql-14-postgis-3 postgresql-14-postgis-3-dbgsym postgresql-14-postgis-3-scripts && \
    rm -rf /var/lib/apt/lists/*

# 复制任何自定义的数据库配置或初始化脚本（如果需要）
# COPY my_init.sql /docker-entrypoint-initdb.d/
# 复制初始化脚本到容器中  
COPY init_db.sh /docker-entrypoint-initdb.d/  
# 确保脚本有执行权限  
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# 暴露PostgreSQL的默认端口
EXPOSE 5432

# 设置容器的默认启动命令
CMD ["postgres"]