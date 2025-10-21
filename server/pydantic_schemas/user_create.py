from pydantic import BaseModel

# ---------------------------
# Pydantic Schemas
# ---------------------------
class UserCreate(BaseModel):
    name: str
    email: str
    password: str
