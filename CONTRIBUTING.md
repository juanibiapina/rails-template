# Contributing to Rails Template

Thank you for your interest in contributing to the Rails Template! This document provides all the information you need to get started with development.

**Important**: Please keep this document up to date as the project evolves. Changes to development processes, new dependencies, or architectural updates should be reflected here.

## Development Setup

1. Run setup script
   ```bash
   bin/setup --skip-server
   ```

## Running Tests

To run the test suite locally:

```bash
# Run all unit and integration tests
bin/rails test

# Run system tests
bin/rails test:system
```

## Linter

To run rubocop use:

```bash
bin/rubocop -f github
```

## Security Scan

To run brakeman for security vulnerability scanning:

```bash
bin/brakeman --no-pager
```

## Application Overview

This is a Rails 8.0 template application that provides a solid foundation for new Rails projects. It includes:

### Models and Data Structure

**User**
- Handles user profiles with names and pictures
- Associated with Account for authentication

**Account**
- Handles authentication via Devise with email/password and Google OAuth
- Includes provider/uid fields for OAuth integration
- One-to-one relationship with User

### Key Features

**Authentication & Authorization**
- User registration and login with email/password
- Google OAuth integration for easy sign-in
- Pundit authorization framework ready to use
- Secure account and user profile management

**User Interface**
- Responsive design with Tailwind CSS
- Modern browser support with progressive enhancement
- Clean, intuitive navigation
- User profile display and management

**Technical Features**
- Rails 8.0 application
- SQLite database for development/test, PostgreSQL for production
- Importmap for JavaScript management
- Tailwind CSS for styling
- Devise for authentication
- Pundit for authorization (ready to use)
- PWA capabilities (partially implemented)
- Sentry integration for error monitoring and performance tracking

**Development & Deployment**
- Docker containerization with multi-stage builds
- Kamal deployment configuration
- GitHub Actions workflows for CI/CD
- Comprehensive test suite (unit, integration, system tests)
- Linting with RuboCop
- Security scanning with Brakeman

### Controllers

**ApplicationController**
- Base controller with Pundit authorization
- Account-based authentication helpers

**HomeController**
- Simple dashboard/landing page for authenticated users

**Accounts::OmniauthCallbacksController** & **Accounts::RegistrationsController**
- Handle OAuth and registration flows
- Modern browser requirement
- Handles authorization errors gracefully

**TripsController**
- Standard CRUD operations for trips
### Development Workflow

Before committing changes:
1. Ensure all tests pass (`bin/rails test`)
2. Ensure system tests pass (`bin/rails test:system`)
3. Run the linter (`bin/rubocop -f github`)
4. Run security scan (`bin/brakeman --no-pager`)

All development commands use the `bin/` prefix for consistency and to ensure the correct versions of tools are used.

### Database Schema

The application uses a simple authentication-focused schema:
- `users` - User profiles with names and pictures
- `accounts` - Authentication data with Devise fields and OAuth integration

Foreign key relationships ensure data integrity, and dependent destroys clean up associated records when parent records are deleted.

### Environment Variables

The application requires the following environment variables for full functionality:

**Required for production:**
- `SENTRY_DSN` - Sentry Data Source Name for error reporting and performance monitoring

**Required for Google OAuth:**
- `GOOGLE_CLIENT_ID` - Google OAuth client ID
- `GOOGLE_CLIENT_SECRET` - Google OAuth client secret

Note: Sentry is only enabled in production and staging environments by default.

## Installing the `pg` gem

To install the `pg` gem on macOS, install libpq:
```sh
brew install libpq
```

And then install the `pg` gem:

``` sh
gem install pg -- --with-pg-config=/opt/homebrew/opt/libpq/bin/pg_config
```
