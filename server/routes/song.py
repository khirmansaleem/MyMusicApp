import uuid
from config import cloudinary   # 👈 this loads the configured instance
import cloudinary.uploader             # 👈 this gives you the upload functions
from fastapi import APIRouter, File, UploadFile
from fastapi.params import Depends, Form
from sqlalchemy.orm import Session
from database import get_db
from middlewares.auth_middleware import auth_middleware

# fetching songs from user 
# uploading the songs
router =APIRouter()


# POST route for uploading songs
# we dont encourage storing thumbnail and songs in the database. 
# so we will use an external service to store files and store 
# the url in the database. 

@router.post('/upload-song')
def upload_song(song: UploadFile=File(...), thumbnail: UploadFile=File(...), 
                artist: str=Form(...), song_name: str=Form(...), 
                hex_code: str=Form(...),
                db : Session= Depends(get_db),
                auth_data: dict = Depends(auth_middleware)):
        # Here, you would typically save the files and metadata to your database 
    song_id= str(uuid.uuid4())
    song_res = cloudinary.uploader.upload(song.file, resource_type= 'auto', folder= f'songs/{song_id}')
    print(song_res)
    thumbnail_res = cloudinary.uploader.upload(thumbnail.file, resource_type= 'image', folder= f'songs/{song_id}')
    print(thumbnail_res)
    # now store all this data in postgres database.
    return 'ok'
    
