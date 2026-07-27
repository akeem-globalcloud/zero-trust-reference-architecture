# Contributing Guide

Thank you for your interest in contributing to the **Zero Trust Reference Architecture** project.

This repository follows an architecture-first engineering approach. Every contribution should improve the project's technical quality, maintainability, or documentation while aligning with Zero Trust principles.

---

# Contribution Principles

All contributions should:

- Follow established Zero Trust security principles.
- Support reusable and vendor-neutral architecture patterns where possible.
- Be well documented.
- Include validation where applicable.
- Maintain consistency with the existing repository structure.

---

# Development Workflow

All work is completed using implementation stories.

Each story should include:

- Business Value
- Description
- Acceptance Criteria
- Deliverables
- Project Structure
- Documentation
- Validation
- Completion Checklist

Stories are stored under:

```
docs/stories/
```

---

# Branch Strategy

Use feature branches for all development.

Example:

```
feature/ZT-001-repository-foundation

feature/ZT-002-zero-trust-architecture

feature/ZT-003-network-security
```

Do not commit directly to the `main` branch.

---

# Commit Message Convention

Follow the Conventional Commits specification.

Examples:

```
feat(terraform): implement enterprise landing zone

feat(identity): add IAM Identity Center architecture

docs(architecture): document Zero Trust principles

docs(story): complete Story ZT-003

fix(terraform): resolve module dependency

refactor(policy): simplify SCP structure
```

---

# Pull Request Guidelines

Each pull request should:

- Address a single story or clearly defined feature.
- Include updated documentation where appropriate.
- Pass all validation checks.
- Reference the related story.
- Describe the implementation and expected outcome.

---

# Documentation Standards

Documentation should:

- Use clear technical language.
- Be vendor-neutral where practical.
- Include diagrams when helpful.
- Reference industry standards where applicable.
- Avoid unnecessary duplication.

---

# Infrastructure Standards

Infrastructure should:

- Use reusable Terraform modules.
- Follow least privilege.
- Encrypt data by default.
- Support Infrastructure as Code best practices.
- Be idempotent.
- Be modular and maintainable.

---

# Security Standards

All implementations should consider:

- Zero Trust Architecture
- Identity-first security
- Least privilege
- Continuous verification
- Defense in depth
- Secure defaults
- Auditability
- Automation

---

# Testing

Where applicable, contributors should validate:

- Terraform formatting
- Terraform validation
- Security scanning
- Documentation accuracy
- Deployment procedures

---

# Code of Conduct

By participating in this project, you agree to follow the project's Code of Conduct.

---

# Questions

Questions, suggestions, and constructive feedback are welcome through GitHub Issues and Discussions.
