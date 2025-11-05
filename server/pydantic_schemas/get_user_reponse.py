from pydantic import BaseModel

class GetUserDataResponse(BaseModel):
    id: str
    name: str
    email: str
    password: str | None = None  # ✅ optional

    model_config = {"from_attributes": True}
