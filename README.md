# Headless CMS for eCommerce

## Overview
This is a **Headless CMS** built with **Golang (Gin) and PostgreSQL** for managing eCommerce content such as products, services, blog posts, and media. It provides a secure, API-only backend for seamless integration with front-end applications.

## Features
- **Headless API**: Pure API-based backend (GraphQL & REST)
- **Authentication**: JWT-based authentication with role-based access control (RBAC)
- **Content Management**: Products, services, blog posts, and categories
- **Media Storage**: Support for storing images, documents, and videos (local PostgreSQL storage for MVP)
- **Full-Text Search**: PostgreSQL `tsvector` for content search
- **Caching**: Redis for performance optimization
- **Scheduled Publishing**: Set future publish dates for content
- **Docker Support**: Easily deployable with Docker & Kubernetes

## Technology Stack
- **Backend**: Golang (Gin Framework)
- **Database**: PostgreSQL
- **API**: GraphQL (recommended) & REST
- **Authentication**: JWT + OAuth2 (optional)
- **Caching**: Redis
- **Search**: PostgreSQL full-text search
- **Storage**: Local PostgreSQL (MVP), AWS S3 (production)
- **Deployment**: Docker, AWS ECS (MVP), Kubernetes (scaling)

## Installation
### Prerequisites
- Golang >= 1.20
- PostgreSQL
- Redis (optional for caching)
- Docker (optional for deployment)

### Clone Repository
```sh
git clone https://github.com/yourusername/headless-cms.git
cd headless-cms
```

### Set Up Environment Variables
Copy the `.env.example` file and update the values:
```sh
cp .env.example .env
```

### Run Database Migrations
```sh
go run scripts/migrate.go
```

### Start the Server
```sh
go run cmd/main.go
```

## API Endpoints
### Authentication
- `POST /auth/register` - Register a new user
- `POST /auth/login` - Login and receive a JWT token

### Products
- `GET /products` - Get a list of products
- `POST /products` - Create a new product
- `PUT /products/{id}` - Update a product
- `DELETE /products/{id}` - Delete a product

### GraphQL API
- The GraphQL playground is available at `/graphql`

## Running with Docker
```sh
docker-compose up --build
```

## Deployment Strategy
- **MVP**: Docker + AWS ECS
- **Scaling**: Kubernetes + AWS RDS + Redis
- **Production Media Storage**: AWS S3 + Cloudflare CDN

## Roadmap
- Implement Webhooks for real-time updates
- Add support for multi-tenancy
- Integrate Elasticsearch for advanced search
- Build a plugin system for extending CMS functionality

## Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -m 'Add feature'`)
4. Push to your branch (`git push origin feature-name`)
5. Open a Pull Request

## License
This project is licensed under the MIT License.

