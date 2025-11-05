from fastapi import APIRouter, File, UploadFile
from fastapi.params import Depends, Form
from sqlalchemy.orm import Session
import cloudinary
import cloudinary.uploader
from database import get_db
from middlewares.auth_middleware import auth_middleware

# fetching songs from user 
# uploading the songs
router =APIRouter()


# Configuration       
cloudinary.config( 
    cloud_name = "donu5vfdz", 
    api_key = "426182853435422", 
    api_secret = "gyhf2Oplhz4_SvoNE06ab2oN1Kk", # Click 'View API Keys' above to copy your API secret
    secure=True
)

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
    return {"message": "Song uploaded successfully"},
