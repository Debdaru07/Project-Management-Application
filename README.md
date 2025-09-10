# Contributing Guidelines

Thank you for your interest in contributing to this project!  
To keep the codebase clean, scalable, and easy to collaborate on, please follow the guidelines below.

---

## 📂 Project Structure

\`\`\`
.
├── backend/   → All backend-intensive code (Python services, APIs, DB integration, etc.)
├── frontend/  → All frontend-intensive code (Flutter Web, UI, State Management, etc.)
└── docs/      → Documentation, PRDs, contribution guides, etc.
\`\`\`


---

## 🌱 Branching Strategy
We follow a **feature-branch workflow**:

### Backend work
- Create branches from `feature/backend/<short-feature-name>`  
- Example: `feature/backend/task-crud`, `feature/backend/project-api`

### Frontend work
- Create branches from `feature/frontend/<short-feature-name>`  
- Example: `feature/frontend/auth-ui`, `feature/frontend/task-dashboard`

### Main branch
- Always keep `main` branch **stable & deployable**.  
- All features must be merged into `main` only after review.  

---

## 📝 Coding Standards

### Backend (Python)
- Follow **PEP8** style guidelines.  
- Organize code into **services, models, and routes**.  
- Use meaningful variable & function names.  
- Add **docstrings** for public functions/classes.  
- Keep **API contracts consistent** with documented PRD.  

### Frontend (Flutter Web)
- Follow **Flutter/Dart style guide**.  
- Keep **widgets modular and reusable**.  
- Place **screens, widgets, services, providers** into logical folders.  
- Use **Riverpod/State management** consistently.  
- Avoid hardcoding styles; use **theme constants**.  

---

## ✅ Pull Requests
- Always create a PR against `main`.  
- PR title format:  
  - `[Backend] Feature: <description>`  
  - `[Frontend] Feature: <description>`  
- Add a **clear description** of changes.  
- Reference any related **issue IDs**.  
- Ensure **tests or manual verification** steps are added.  

---

## 🔍 Code Review
- Every PR requires at least **one reviewer approval**.  
- Be open to suggestions for **refactoring and improvements**.  
- Small PRs are preferred over large ones.  

---

## 🧪 Testing
- **Backend:** Test endpoints with sample payloads (Postman/cURL).  
- **Frontend:** Test UI flows in local dev environment before raising PR.  
- Ensure nothing is broken in **task/project CRUD flows**.  

---

## 🚀 Deployment
- **Backend** will be hosted (e.g., Render / Supabase functions).  
- **Frontend** will be deployed as Flutter Web build.  
- Always verify deployment in **staging/test environment** before pushing live.  
