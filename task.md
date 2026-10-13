# README.md

````md
# AI Todo App

A modern full-stack todo application built for experimenting with AI-assisted software development workflows.

## Goals

This project is designed to:

- Benchmark AI coding models and coding agents
- Explore vibe-coding workflows
- Build a production-quality React + Python application
- Test local and cloud AI tooling
- Evaluate architecture and code quality across models

---

## Tech Stack

### Frontend

- React
- TypeScript
- TailwindCSS
- TanStack Router
- TanStack Query
- Vite

### Backend

- Python
- FastAPI
- SQLAlchemy
- Alembic
- SQLite (initially)

### AI / Dev Infrastructure

- Ollama
- Qwen3
- OpenRouter
- Claude Code
- Hermes Agent
- Open WebUI
- Qdrant

---

## Features

### Core Todo Features

- Create todos
- Edit todos
- Delete todos
- Mark todos complete
- Priority levels
- Due dates
- Categories/tags
- Search/filter/sort

### UX Features

- Responsive design
- Dark mode
- Optimistic UI updates
- Loading/error states
- Keyboard shortcuts

### Future Features

- Authentication
- Real-time sync
- AI-assisted task suggestions
- Natural language task creation
- Notifications/reminders
- Team collaboration

---

## Project Structure

```text
frontend/
backend/
docs/
````

---

## Development Philosophy

This project prioritizes:

* Clean architecture
* Simplicity over over-engineering
* Incremental development
* Strong typing
* Reusable components
* Explicit documentation
* AI-agent-friendly structure

---

## Local Development

### Frontend

```bash
cd frontend
npm install
npm run dev
```

### Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload
```

---

## AI Workflow

Primary development workflow:

```text
Claude Code / OpenCode
        ↓
OpenRouter + Ollama
        ↓
Qwen3 / DeepSeek / Claude / MiniMax
```

---

## Current Status

Project is in initial architecture and scaffolding phase.

````

---

# PROJECT_PLAN.md

```md
# Project Plan

## Vision

Build a modern production-quality todo application while evaluating AI coding workflows, model quality, and agentic development patterns.

---

# Phase 1 — Foundation

## Objectives

- Initialize frontend and backend projects
- Establish project structure
- Configure tooling
- Configure linting and formatting
- Setup database and migrations
- Setup API scaffolding
- Create initial UI shell

## Deliverables

### Frontend

- Vite + React + TypeScript
- TailwindCSS setup
- TanStack Router setup
- TanStack Query setup
- Shared layout
- Theme system

### Backend

- FastAPI setup
- SQLAlchemy setup
- Alembic migrations
- Health endpoints
- Environment configuration
- Database connection layer

---

# Phase 2 — Core Todo Functionality

## Objectives

Implement complete CRUD functionality.

## Deliverables

- Todo database model
- Todo API endpoints
- Validation schemas
- Frontend forms
- Todo list UI
- State synchronization
- Error handling

---

# Phase 3 — UX Improvements

## Objectives

Improve usability and responsiveness.

## Deliverables

- Dark mode
- Search
- Filtering
- Sorting
- Responsive layout
- Keyboard shortcuts
- Toast notifications
- Loading skeletons

---

# Phase 4 — Testing & Stability

## Objectives

Improve reliability and maintainability.

## Deliverables

- Backend API tests
- Frontend component tests
- End-to-end tests
- Error boundary handling
- Logging improvements

---

# Phase 5 — AI Enhancements

## Objectives

Experiment with AI-assisted features.

## Potential Features

- Natural language todo creation
- AI prioritization suggestions
- Smart categorization
- Semantic search
- Embedding-based recommendations

---

# Architecture Decisions

## Frontend

### Chosen Stack

- React for UI
- TanStack Router for routing
- TanStack Query for server state
- TailwindCSS for styling

### Principles

- Component-driven design
- Minimal global state
- Strong typing
- Reusable UI primitives

---

## Backend

### Chosen Stack

- FastAPI for API layer
- SQLAlchemy ORM
- Alembic migrations
- SQLite initially

### Principles

- Service-oriented architecture
- Clear separation of concerns
- Typed schemas
- Centralized validation

---

# Risks

## Technical Risks

- Over-engineering early
- AI-generated architectural drift
- Context loss across sessions
- Inconsistent coding styles between models

## Mitigation

- Keep documentation updated
- Develop incrementally
- Review generated code carefully
- Maintain strict project structure

---

# Success Criteria

The project is successful if:

- Application is production deployable
- Architecture remains clean and maintainable
- AI workflows improve productivity
- Multiple models can contribute effectively
- Documentation remains accurate
````

---

# TASKS.md

```md
# Tasks

## Current Priority

Establish project foundation and baseline architecture.

---

# Backlog

## Infrastructure

- [ ] Finalize Docker environment
- [ ] Verify Ollama networking
- [ ] Verify Hermes integration
- [ ] Configure OpenRouter models
- [ ] Test Claude Code workflows

---

## Frontend Setup

- [ ] Create Vite React TypeScript app
- [ ] Install TailwindCSS
- [ ] Configure TanStack Router
- [ ] Configure TanStack Query
- [ ] Setup ESLint + Prettier
- [ ] Create layout shell
- [ ] Create dark mode system

---

## Backend Setup

- [ ] Create FastAPI application
- [ ] Configure SQLAlchemy
- [ ] Setup Alembic migrations
- [ ] Add environment configuration
- [ ] Create health endpoint
- [ ] Setup logging

---

## Todo Features

- [ ] Create todo model
- [ ] Create todo CRUD endpoints
- [ ] Create frontend todo form
- [ ] Create todo list component
- [ ] Add optimistic updates
- [ ] Add loading states
- [ ] Add validation handling

---

## Search & Filtering

- [ ] Add text search
- [ ] Add category filtering
- [ ] Add priority filtering
- [ ] Add sorting options
- [ ] Add due date filtering

---

## Testing

- [ ] Add backend unit tests
- [ ] Add frontend component tests
- [ ] Add API integration tests
- [ ] Add E2E tests

---

## AI Experiments

- [ ] Compare Claude vs DeepSeek outputs
- [ ] Compare MiniMax vs Qwen workflows
- [ ] Evaluate token efficiency
- [ ] Measure repo understanding quality
- [ ] Benchmark debugging ability

---

# Notes

## Workflow Rules

- Keep implementation incremental
- Avoid unnecessary abstractions
- Update documentation after major changes
- Prefer modifying existing files over excessive file creation
- Keep architecture simple unless complexity is justified

---

## AI Session Recovery

When resuming work:

1. Read README.md
2. Read PROJECT_PLAN.md
3. Read TASKS.md
4. Summarize current implementation state
5. Continue from highest-priority unfinished tasks
```
