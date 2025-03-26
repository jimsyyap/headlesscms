# Headless CMS for eCommerce - Project Reference Guide

## Overview
This guide provides a comprehensive reference for the Headless CMS project, covering architecture, database schema, API design, authentication, caching, search, and deployment.

## 1. Technology Stack
- **Backend:** Golang (Gin Framework)
- **Database:** PostgreSQL
- **API:** GraphQL (recommended for flexibility)
- **Authentication:** JWT with OAuth2 (optional for third-party login)
- **Caching:** Redis (for performance optimization)
- **Search:** PostgreSQL full-text search (tsvector)
- **Storage:** Local PostgreSQL for MVP, AWS S3 in production
- **Deployment:** Docker, AWS ECS (MVP), Kubernetes (scaling)

## 2. Database Schema
### Users & Authentication
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role_id UUID NOT NULL REFERENCES roles(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### Products & Services
```sql
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'USD',
    stock_quantity INT DEFAULT 0,
    is_published BOOLEAN DEFAULT FALSE,
    publish_at TIMESTAMP,
    category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### Blog Posts & Articles
```sql
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    content TEXT NOT NULL,
    author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    is_published BOOLEAN DEFAULT FALSE,
    publish_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

## 3. API Design
- **Authentication API:** JWT-based authentication
- **GraphQL Endpoints:** CRUD operations for users, products, services, posts, media
- **Role-Based Access Control (RBAC):** Permissions for admin, editor, viewer

## 4. Caching & Search
- **Redis for caching:** Frequently accessed content (e.g., product listings, blog posts)
- **Full-Text Search:** PostgreSQL `tsvector` for product and post searches

## 5. Deployment Strategy
- **MVP:** Docker + AWS ECS (Elastic Container Service)
- **Scaling:** Kubernetes + AWS RDS for PostgreSQL, ElastiCache for Redis
- **Media Storage:** AWS S3 (post-MVP), Cloudflare CDN for performance

## 6. Next Steps
- Implement GraphQL API endpoints
- Develop role-based authentication and permissions
- Optimize PostgreSQL performance with indexing
- Deploy MVP version on AWS

## 7. Future Enhancements
- Elasticsearch for advanced search
- Multi-tenancy support
- Webhook and plugin system
- Analytics & reporting for eCommerce insights

### directory structure

headless-cms/
│── cmd/                    # Entry point for the application  
│   ├── main.go             # Main application file  
│  
│── config/                 # Configuration files  
│   ├── config.yaml         # App configurations (DB, API keys, etc.)  
│   ├── env/                # Environment-specific configs  
│  
│── internal/               # Internal app logic  
│   ├── auth/               # Authentication & JWT handling  
│   │   ├── jwt.go  
│   │   ├── middleware.go  
│   │  
│   ├── handlers/           # API handlers/controllers  
│   │   ├── product_handler.go  
│   │   ├── post_handler.go  
│   │  
│   ├── models/             # Database models  
│   │   ├── product.go  
│   │   ├── post.go  
│   │   ├── user.go  
│   │  
│   ├── repositories/       # Database access layer  
│   │   ├── product_repo.go  
│   │   ├── post_repo.go  
│   │   ├── user_repo.go  
│   │  
│   ├── services/           # Business logic layer  
│   │   ├── product_service.go  
│   │   ├── post_service.go  
│   │  
│   ├── search/             # Full-text search (PostgreSQL)  
│   │   ├── search.go  
│   │  
│   ├── cache/              # Redis caching logic  
│   │   ├── cache.go  
│   │  
│── migrations/             # Database migration files  
│   ├── 001_init_schema.sql  
│   ├── 002_add_indexes.sql  
│  
│── pkg/                    # Utility packages  
│   ├── logger/             # Logging system  
│   ├── utils/              # Helper functions  
│  
│── api/                    # API definitions  
│   ├── graphql/            # GraphQL schema & resolvers  
│   │   ├── schema.graphql  
│   │   ├── resolvers.go  
│   │  
│   ├── rest/               # REST API (if needed)  
│   │   ├── routes.go  
│  
│── scripts/                # Helper scripts (e.g., database seeding)  
│   ├── seed_data.go  
│  
│── tests/                  # Unit & integration tests  
│   ├── auth_test.go  
│   ├── product_test.go  
│  
│── Dockerfile              # Docker configuration  
│── docker-compose.yml      # Docker Compose setup  
│── .env                    # Environment variables  
│── go.mod                  # Go module dependencies  
│── README.md               # Project documentation  
