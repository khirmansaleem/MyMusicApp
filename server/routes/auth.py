import uuid
import bcrypt
from fastapi import APIRouter, Depends, HTTPException
import jwt
from models.user import User
from pydantic_schemas.user_create import UserCreate
from pydantic_schemas.user_response import UserLoginResponse, UserResponse
from database import get_db
from sqlalchemy.orm import Session
from pydantic_schemas.user_response import UserLoginResponse, UserResponse
from config import JWT_SECRET_KEY
from pydantic_schemas.user_login import UserLogin
from middlewares.auth_middleware import auth_middleware
from pydantic_schemas.get_user_reponse import GetUserDataResponse
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
@router.post("/login", response_model=UserLoginResponse)
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db:
        raise HTTPException(status_code=400, detail="User not found")

    hashed_pw = bytes(user_db.password)
    if not bcrypt.checkpw(user.password.encode("utf-8"), hashed_pw):
        raise HTTPException(status_code=400, detail="Incorrect password")

    token = jwt.encode(
        {"id": user_db.id},
        JWT_SECRET_KEY,
        algorithm="HS256",
    )
      # 4️⃣ Decode memoryview → string for Pydantic
    user_db.password = hashed_pw.decode("utf-8")

    user_data = UserResponse.model_validate(user_db)

    return {"token": token, "user": user_data}

#================================================================
# ======== Router to Get token from Client Side and return user data =============
#====================================================================================

@router.get('/', response_model=GetUserDataResponse)

# Use the auth_middleware to extract and verify the token
# Then fetch and return the user data based on the user_id from the token
# The auth_middleware will provide user_data containing token and user_id

# return only user data not token
def get_user_data(db: Session = Depends(get_db), user_data: dict = Depends(auth_middleware)):
    # Extract user_id from the user_data provided by the middleware
    user_id = user_data['user_id']
    user_db = db.query(User).filter(User.id == user_id).first()
    if not user_db:
        raise HTTPException(status_code=404, detail="User not found")
    # Convert memoryview or bytes to string for response serialization
    if isinstance(user_db.password, memoryview):
        user_db.password = user_db.password.tobytes().decode('utf-8')
    
    user_dict = {
    "id": user_db.id,
    "name": user_db.name,
    "email": user_db.email
  }
    user_data = GetUserDataResponse.model_validate(user_dict)
    # how to return only user data not token
    return user_data
   


    


    

    


    