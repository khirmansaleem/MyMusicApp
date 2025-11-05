#“Extract your JWT verification into a single reusable component
# (middleware or dependency) so you don’t repeat that code in every route.”
#Middleware runs on every request before reaching your routes.
# if you want to enforce authentication globally (like checking JWT for all routes except /login and /signup).
from http.client import HTTPException
from fastapi.params import Header
import jwt
from config import JWT_SECRET_KEY


def auth_middleware(x_auth_token: str = Header()):
    try:
        if not x_auth_token:
            raise HTTPException(status_code=401, detail="Authorization token missing")

        verified_token = jwt.decode(x_auth_token, JWT_SECRET_KEY, algorithms=["HS256"])
        user_id = verified_token.get('id')
        if not user_id:
            raise HTTPException(status_code=401, detail="Invalid token payload")

        return {"token": x_auth_token, "user_id": user_id}

    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid or tampered token")
