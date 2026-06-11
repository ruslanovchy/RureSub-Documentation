# RureSub

**RureSub** - A high-load social network built on a microservices architecture using many modern technologies.
The social network was developed and is continuously being improved as a pet project to demonstrate skills in software development and building high-load architectures.

RureSub currently has basic social network functionality.

## Links

[**Visit the website**](https://prudently-pseudoofficial-josefina.ngrok-free.dev)

## Tech Stack

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
![MinIO](https://img.shields.io/badge/MinIO-99312f?style=for-the-badge&logo=minio&logoColor=white)

**Other**

![Apache Kafka](https://img.shields.io/badge/Apache%20Kafka-000000?style=for-the-badge&logo=apachekafka&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Amazon S3](https://img.shields.io/badge/Amazon%20S3-FF9900?style=for-the-badge&logo=amazons3&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

## Architecture Diagram

![Diagram](assets/diagrams/architecture.png)

| Microservice   | Technologies | Purpose | Databases | Repository |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Frontend  | ReactJS | Website pages | None | None |
| MinIO | MinIO | Media file storage | None | None |
| Kafka  | Kafka | Message broker between services | None | None |
| Identity  | ASP.NET | User authentication, account creation, <br>issuing and storing JWT tokens | PostgreSQL | [Go](https://github.com/ruslanovchy/RureSubIdentity) |
| Profiles  | ASP.NET | User profiles, display name, avatars, <br>banners and other settings | PostgreSQL | [Go](https://github.com/ruslanovchy/RureSubProfiles) |
| Email  | ASP.NET | Sending emails | None | [Go](https://github.com/ruslanovchy/RureSubEmail) |
| Posts Writer  | ASP.NET | Publishing posts and source of truth | PostgreSQL | [Go](https://github.com/ruslanovchy/RureSubPostsWriter) |
| Posts Reader  | ASP.NET | Reading, fast delivery and caching of posts | MongoDB, Redis | [Go](https://github.com/ruslanovchy/RureSubPostsReader) |
| Posts Likes  | ASP.NET | Post likes, storing which users liked which posts | Redis | [Go](https://github.com/ruslanovchy/RureSubPostsLikes) |
| Posts Comments  | ASP.NET | Post comments, storing which users <br>commented on which posts | MongoDB, Redis | [Go](https://github.com/ruslanovchy/RureSubPostsComments) |
| Followers | ASP.NET | User subscriptions, storing who follows whom | PostgreSQL, Redis | [Go](https://github.com/ruslanovchy/RureSubFollowers) |

## Architectural Patterns

**Communication**

Services communicate with each other asynchronously via **Kafka**. **HTTP** requests between services are used in some cases. One such case is **Posts Writer**. When a new post is created, **Posts Writer** sends a request to **Profiles** to fetch the author's profile data, saves it to its own database, and publishes the message to **Kafka**. **Posts Reader** then processes the messages and stores all post information — including the author's name, avatar, etc. — denormalized in **MongoDB**.

**CQRS**

Post publishing and reading happen in separate services. The read load is significantly higher than the write load, so splitting these operations into two independent services was the logical solution.

**Transactional Outbox/Inbox**

All services use the Transactional Outbox pattern to guarantee message delivery to Kafka. The Transactional Inbox pattern is also used to ensure message idempotency.

## Frontend

The site features a minimalist design inspired by Reddit, Instagram, and TikTok. It is dynamic, with animations throughout. Libraries such as Swiper are used for media file display in posts. Post text can be styled using standard Markdown formatting.

## Screenshots

**Home page**

![1](assets/screenshots/1.png)

**Post creation page**

![2](assets/screenshots/2.png)

**User profile**

![3](assets/screenshots/3.png)

**Settings**

![4](assets/screenshots/4.png)

## How to Run

The repository contains a **compose** folder with everything needed to run **docker compose**. Make sure you have **[Docker](https://www.docker.com/)** installed before getting started. You will also need to set several environment variables in the **.env** file, such as **JWT_KEY**, **EMAIL_ADDRESS**, and **EMAIL_PASSWORD**.

To run the application, download the compose folder or the full repository, open a terminal, navigate to the **compose** folder, and run **docker compose up**. Some operating systems may require read permissions for the **postgres-init-scripts** and **mongo-init-scripts** folders.