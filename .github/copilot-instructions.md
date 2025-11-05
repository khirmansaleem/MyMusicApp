## Copilot instructions — MyMusicApp (concise project facts)

This repo is a two-part app: a Flutter client in `/client` and a FastAPI server in `/server`.

Key facts for an AI to be immediately productive:

- Architecture
  - Frontend: `client/` (Flutter). Entry: `client/lib/main.dart`. Dependencies in `client/pubspec.yaml` (Riverpod, http, shared_preferences).
  - Backend: `server/` (FastAPI). Entry: `server/main.py`. Routes are in `server/routes/` (e.g. `auth.py`). Models: `server/models/`. Pydantic schemas: `server/pydantic_schemas/`.
  - DB: PostgreSQL connection string lives in `server/database.py` (uses SQLAlchemy engine + SessionLocal). The server currently calls `Base.metadata.create_all(bind=engine)` on startup; there is no migration tooling (Alembic) present.

- How to run (discoverable)
  - Server (dev): cd into `server/` and run: `uvicorn main:app --reload --port 8000`. The app object is `app` in `server/main.py`.
  - Client: cd into `client/` and run: `flutter pub get` then `flutter run` (or run from IDE).

- Important code patterns & conventions
  - Dependency injection: DB sessions are provided via `server/database.py::get_db` and used with `Depends(get_db)` (see `server/routes/auth.py`).
  - Response models: routes commonly use Pydantic response models (see `pydantic_schemas/user_response.py`). Follow existing shape when returning user objects.
  - Auth flow: signup/login implemented in `server/routes/auth.py`:
    - Passwords hashed with `bcrypt` before storing.
    - JWTs are created with `jwt.encode({...}, JWT_SECRET_KEY, algorithm="HS256")` using `server/config.py` to read `JWT_SECRET_KEY` from environment (`.env`).
  - IDs: user ids are UUID strings (see `uuid.uuid4()` usage in `auth.py`).

- Integration notes & risks
  - DB URL in `server/database.py` contains credentials and points to `localhost:5432/fluttermusicapp` — treat this as a local dev DB and do not commit secrets. Production secrets live in environment variables (see `server/config.py` which uses `python-dotenv`).
  - No migrations: schema changes will be applied via SQLAlchemy `create_all`, so changes may be lost or mismatched across environments.

- Where to make common changes
  - Add new API routes in `server/routes/` and include them in `server/main.py` via `app.include_router(...)` with a clear prefix.
  - Add new DB models under `server/models/` and import `models.base.Base` for declarative classes.
  - Add Pydantic shapes under `server/pydantic_schemas/` and use them as `response_model` on route decorators.

- Quick examples (copy-paste friendly)
  - Create a dev JWT secret file: create `server/.env` with `JWT_SECRET_KEY=your_dev_secret` before running server.
  - Start server (from repo root):
    - `cd server; uvicorn main:app --reload --port 8000`

- Tests & CI
  - No test framework or CI configuration detected. If adding tests, prefer pytest for the server and Flutter's `flutter_test` for the client.

If anything here looks incomplete or you want more detail (example endpoints, preferred lint/format rules, or migration guidance), tell me which area to expand and I'll iterate.
