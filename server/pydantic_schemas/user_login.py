from pydantic import BaseModel

# ---------------------------
# Pydantic Schemas
# ---------------------------
class UserLogin(BaseModel):
    email: str
    password: str
