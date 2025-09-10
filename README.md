Contributing Guidelines

Thank you for your interest in contributing to this project!
To keep the codebase clean, scalable, and easy to collaborate on, please follow the guidelines below.

📂 Project Structure
.
├── backend/   → All backend-intensive code (Python services, APIs, DB integration, etc.)
├── frontend/  → All frontend-intensive code (Flutter Web, UI, State Management, etc.)
└── docs/      → Documentation, PRDs, contribution guides, etc.

🌱 Branching Strategy

We follow a feature-branch workflow:

Backend work:

Create branches from feature/backend/<short-feature-name>

Example: feature/backend/task-crud, feature/backend/project-api

Frontend work:

Create branches from feature/frontend/<short-feature-name>

Example: feature/frontend/auth-ui, feature/frontend/task-dashboard

Main branch:

Always keep main branch stable & deployable.

All features must be merged into main only after review.
