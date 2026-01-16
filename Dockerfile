FROM jupyter/base-notebook:python-3.11 AS base-image

# Убедимся, что папка /var/lib/apt/lists имеет правильные права доступа
USER root
RUN chown -R root:root /var/lib/apt/lists && mkdir -p /var/lib/apt/lists/partial

# Установка Java OpenJDK
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk-headless && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Java успешно установлен!"

# Переход к рабочему каталогу
WORKDIR /home/jovyan/project

# Настройка переменных окружения
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
ENV PATH=$JAVA_HOME/bin:$PATH

# Запуск Jupyter Notebook
CMD ["sh", "-c", "start-notebook.py --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.notebook_dir=/home/jovyan/project"]