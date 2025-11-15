from fastapi import FastAPI
from  models.base import Base
from database import engine
from routes import auth
from fastapi.middleware.cors import CORSMiddleware
from routes import song



app = FastAPI()
app.include_router(auth.router,prefix='/auth')
app.include_router(song.router,prefix='/songs')
Base.metadata.create_all(bind=engine)
   
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


