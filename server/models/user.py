from sqlalchemy import TEXT, VARCHAR, Column
from models.base import Base

# ---------------------------------------------------
# Database Model
# ---------------------------------------------------

class User(Base):
    __tablename__ = 'users'

    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100), nullable=False)
    email = Column(VARCHAR(100), nullable=False, unique=True)
    password = Column(VARCHAR(100), nullable=False)

