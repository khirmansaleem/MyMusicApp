import uuid
import bcrypt
from fastapi import APIRouter, Depends, HTTPException
from models.user import User
from pydantic_schemas.user_create import UserCreate
from pydantic_schemas.user_response import UserResponse
from database import get_db
from sqlalchemy.orm import Session
from pydantic_schemas.user_login import UserLogin
# -------------------------------------------------------------------------------------
# ----------------------------------Route----------------------------------------------
# --------------------------------------------------------------------------------------
router=APIRouter()

@router.post('/signup', response_model=UserResponse,status_code=201)
def signup_user(user: UserCreate, db : Session= Depends(get_db)):
    
    # check if user already exist in database
    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(status_code=400, detail='User with same email already exists!')
    
    # Hash the password using bcrypt
    hashed_pw = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
    # Add user to the database
    user_db = User(id=str(uuid.uuid4()), email=user.email, password=hashed_pw, name=user.name)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    # Convert memoryview or bytes to string for response serialization
    if isinstance(user_db.password, memoryview):
        user_db.password = user_db.password.tobytes().decode('utf-8')
    
    return user_db
#----------------------------------------------------------------------------------------------
#------------------ LOGIN ROUTER for user login handling ----------------------------------------
#-----------------------------------------------------------------------------------------------
@router.post('/login', response_model=UserResponse)
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    # 1️⃣ Check if user exists
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db:
        raise HTTPException(status_code=400, detail='User does not exist in the database.')

    # 2️⃣ Convert memoryview to bytes
    hashed_pw = bytes(user_db.password)

    # 3️⃣ Convert plain password to bytes and compare
    is_match = bcrypt.checkpw(user.password.encode('utf-8'), hashed_pw)
    if not is_match:
        raise HTTPException(status_code=400, detail='Incorrect password.')

    # 4️⃣ Optional: convert hashed password to string for response (debug only)
    user_db.password = hashed_pw.decode('utf-8')

    return user_db

    


    