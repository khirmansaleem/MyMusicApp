
I developed a Flutter-based music application that includes features like:

* user authentication (login/signup)
* uploading songs
* adding songs to the library
* a music slab
* a complete music player
* and a recently played songs section

I built the frontend using Flutter and the backend using FastAPI and PostgreSQL. User authentication is stored in PostgreSQL, and JWT tokens are used for state persistence of logged-in users.
Songs data is stored in Cloudinary and referenced in PostgreSQL, while Hive local storage is used for the library songs.
I followed feature-wise development, MVVM architecture, and used Riverpod for state management.

