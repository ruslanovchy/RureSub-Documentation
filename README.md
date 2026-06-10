# RureSub

**RureSub** - Высоконагруженная социальная сеть на микросервисной архитектуре с использованием многих современных технологий.
Социальная сеть была разработана и дорабатывается в качестве пет-проекта для демонстрации навыков в программировании и построении высоконагруженных архитектур.

На данный момент RureSub имеет базовый и первонеобходимый функционал для социальных сетей.

## Стек технологий

**Backend**

![C#](https://img.shields.io/badge/c%23-%23239120.svg?style=for-the-badge&logo=c-sharp&logoColor=white)
![.NET](https://img.shields.io/badge/.NET-512BD4?style=for-the-badge&logo=.net&logoColor=white)
![ASP.NET](https://img.shields.io/badge/ASP.NET-3980a8?style=for-the-badge&logo=.net&logoColor=white)
![JWT](https://img.shields.io/badge/JWT-0e0b17?style=for-the-badge&logo=JSON%20web%20tokens)

**Frontend**

![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)
![SCSS](https://img.shields.io/badge/-SCSS-black?style=for-the-badge&logo=SASS)
![React Query](https://img.shields.io/badge/-React--Query-FF4154?style=for-the-badge&logo=react-query&logoColor=white)
![Axios](https://img.shields.io/badge/axios-854195?style=for-the-badge&logo=axios&logoColor=white)

**Databases**

![MongoDB](https://img.shields.io/badge/MongoDB-%2347A248.svg?style=for-the-badge&logo=mongodb&logoColor=white)
![Redis](https://img.shields.io/badge/redis-%23DD0031.svg?style=for-the-badge&logo=redis&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)

**Other**

![Apache Kafka](https://img.shields.io/badge/Apache%20Kafka-000000?style=for-the-badge&logo=apachekafka&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Amazon S3](https://img.shields.io/badge/Amazon%20S3-FF9900?style=for-the-badge&logo=amazons3&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

## Архитектурная диаграмма

![Diagram](assets/diagrams/architecture.png)



| Микросервис  | Технологии | Назначение | Базы данных |
| ------------- | ------------- | ------------- | ------------- |
| Frontend  | ReactJS | Страницы сайта | Нет |
| Amazon S3(minio)  | Временно MinIO | Хранение медиа файлов сайта | MinIO |
| Kafka  | Kafka | Брокер сообщений между сервисами | Kafka |
| Identity  | ASP.NET | Авторизация пользователей, создание аккаунтов, <br>выдача и хранение JWT токенов | PostgreSQL |
| Profiles  | ASP.NET | Профили пользователей, display name, аватары, <br>баннеры и прочие настройки | PostgreSQL |
| Email  | ASP.NET | Отправка сообщений по электронной почте | Нет |
| Posts Writer  | ASP.NET | Публикация постов и источник истины | PostgreSQL |
| Posts Reader  | ASP.NET | Чтение, быстрая отдача и кэширование постов | MongoDb, Redis |
| Posts Likes  | ASP.NET | Лайки постов, хранение кто какие посты лайкнул | Redis |
| Posts Comments  | ASP.NET | Комментарии постов, хранение кто на какие <br>посты оставил комментарий | MongoDb, Redis |
| Followers | ASP.NET | Подписки пользователей, хранение кто на кого подписан | Redis |

## Архитектурные паттерны

**Коммуникация**

Сервисы общаются между собой через **Kafka** асинхронно. Для некоторых случаев используется **HTTP** запросы между сервисами. Один из таких случаев в **Posts Writer**. Когда создается новый пост, **Posts Writer** делает запрос на **Profiles** для получения данных профиля автора, затем хранит всю информацию о посте включая имя автора, аватар автора итд. в **MongoDb** денормализованно

**CQRS**

Публикация и чтение постов происходят в разных сервисах. Нагрузка на сервис чтения постов намного выше нагрузки на сервис публикаций, поэтому разумным Решением было разделить эти операции на два независимых сервиса.

**Transactional Outbox/Inbox**

Для гарантированной отправки сообщений в Kafka во всех сервисах используется шаблон Transactional Outbox. Так же для идемпотентности сообщений используется шаблон Transactinoal Inbox

## Скриншоты страниц

