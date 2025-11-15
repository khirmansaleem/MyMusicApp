# song model
from sqlalchemy import Column, String, DateTime
from datetime import datetime
from sqlalchemy.dialects.postgresql import UUID
import uuid
from models.base import Base

class Song(Base):
    __tablename__ = "songs"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    artist = Column(String, nullable=False)
    song_name = Column(String, nullable=False)
    hex_code = Column(String, nullable=True)
    song_url = Column(String, nullable=False)
    thumbnail_url = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    user_id = Column(String, nullable=True)  # optional if you track who uploaded
