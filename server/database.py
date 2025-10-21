from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# ---------------------------
# Database Configuration
# ---------------------------

DATABASE_URL = 'postgresql://postgres:nbcak2019@localhost:5432/fluttermusicapp'
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
