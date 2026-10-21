# PHP FileManager - DevOps Test

Тестовое задание Junior DevOps Engineer.

Проект запускает PHP FileManager в Docker-контейнерах.
Nginx обрабатывает HTTP-запросы, а PHP-FPM выполняет PHP-код.
Docker Compose управляет контейнерами.
Ansible автоматизирует развертывание на удаленном сервере.

## 1. Требования

Для локального запуска необходимы:

- Docker
- Docker Compose v2

Для развертывания на сервере дополнительно нужны:

- Ansible
- SSH-доступ к серверу
- Права sudo на удаленном сервере

## 2. Локальный запуск

Клонируйте репозиторий:

    git clone https://github.com/Vadyankaa/php-devops-test.git

Перейдите в каталог проекта:

    cd php-devops-test

Соберите образы и запустите контейнеры:

    docker compose up -d --build

Откройте приложение в браузере:

    http://localhost:8088

Проверить состояние контейнеров:

    docker compose ps

Посмотреть логи:

    docker compose logs -f

Остановить контейнеры:

    docker compose down

## 3. Настройка порта

По умолчанию приложение доступно на порту 8088.

Чтобы использовать другой порт, задайте переменную APP_PORT.

Например, для порта 8090:

    APP_PORT=8090 docker compose up -d --build

После запуска откройте:

    http://localhost:8090

## 4. Развертывание через Ansible

Конфигурация Ansible находится в каталоге ansible.

Структура каталогов:

- inventory/ - инвентари серверов Dev и Prod
- group_vars/ - переменные окружений
- templates/ - шаблоны конфигураций
- deploy.yml - Playbook развертывания

Перед запуском необходимо настроить:

- IP-адрес сервера
- SSH-пользователя
- URL Git-репозитория
- Ветку Git
- Домен приложения
- Порт приложения

Параметры по умолчанию находятся в файле:

    ansible/group_vars/all.yml

Настройки Dev:

    ansible/group_vars/dev.yml

Настройки Prod:

    ansible/group_vars/prod.yml

Инвентарь Dev:

    ansible/inventory/dev.ini

Инвентарь Prod:

    ansible/inventory/prod.ini

## 5. Проверка Ansible

Проверить синтаксис Playbook:

    ansible-playbook --syntax-check -i ansible/inventory/dev.ini ansible/deploy.yml

Перед реальным запуском замените демонстрационные IP-адреса
и домены на свои значения.

## 6. Развертывание в Dev

Пример команды:

    ansible-playbook -i ansible/inventory/dev.ini ansible/deploy.yml -e "git_branch=master app_domain=dev.example.com app_port=8088"

Здесь:

- git_branch - ветка Git для развертывания
- app_domain - домен приложения
- app_port - HTTP-порт на сервере

## 7. Развертывание в Prod

Пример команды:

    ansible-playbook -i ansible/inventory/prod.ini ansible/deploy.yml -e "git_branch=master app_domain=example.com app_port=80"

Замените example.com на свой домен.

Параметры, переданные через -e, переопределяют значения
из файлов переменных Ansible.

Домен должен указывать на IP-адрес сервера.
Для работы по HTTPS потребуется отдельная настройка TLS.

Не запускайте развертывание, пока в инвентарях указаны
демонстрационные IP-адреса.

## 8. Структура проекта

- Dockerfile - образ PHP-FPM
- compose.yaml - локальный запуск приложения
- nginx/default.conf - конфигурация локального Nginx
- ansible/deploy.yml - автоматизация развертывания
- ansible/inventory/ - серверы Dev и Prod
- ansible/group_vars/ - переменные окружений
- ansible/templates/ - шаблоны конфигураций

## 9. Примечание

Проект предназначен для демонстрации контейнеризации
PHP-приложения и автоматизации развертывания.

Перед использованием в production рекомендуется настроить
HTTPS, права доступа, безопасность загрузки файлов
и резервное копирование.
