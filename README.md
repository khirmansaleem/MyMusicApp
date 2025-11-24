I developed a Flutter-based music application with features such as:

- user authentication (login/signup)

- uploading songs

- adding songs to a personal library

- a music slab UI

- a full music player

and a recently played section

Tech Stack:

- Frontend: Flutter

- Backend: FastAPI

- Database: PostgreSQL

- Authentication: JWT tokens

- Cloud Storage: Cloudinary for song files

- Local Storage: Hive for library songs

- Architecture: MVVM + feature-wise structure

- State Management: Riverpod

User accounts and authentication are handled with PostgreSQL, and JWT tokens are used for session persistence. Songs are uploaded to Cloudinary and linked through PostgreSQL, while Hive is used to store songs locally for fast access inside the app.
