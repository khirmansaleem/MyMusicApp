import uuid
import cloudinary
from cloudinary import uploader
from fastapi import APIRouter, File, UploadFile, Form, Depends
from sqlalchemy.orm import Session
from database import get_db
from middlewares.auth_middleware import auth_middleware
from models.song import Song
from config import *  # loads .env and configures Cloudinary

router =APIRouter()

@router.post('/upload-song', status_code=201)
def upload_song(
    song: UploadFile = File(...),
    thumbnail: UploadFile = File(...),
    artist: str = Form(...),
    song_name: str = Form(...),
    hex_code: str = Form(...),
    db: Session = Depends(get_db),
    auth_data: dict = Depends(auth_middleware)
):
    try:

        # Generate a unique ID for this song folder
        song_id = str(uuid.uuid4())

        # Upload song file to Cloudinary
        song_res = cloudinary.uploader.upload(
            song.file,
            resource_type='auto',
            folder=f'songs/{song_id}/audio'
        )
        print("Uploaded song:", song_res['url'])

        # Upload thumbnail file to Cloudinary
        thumbnail_res = cloudinary.uploader.upload(
            thumbnail.file,
            resource_type='image',
            folder=f'songs/{song_id}/thumbnails'
        )
        print("Uploaded thumbnail:", thumbnail_res['url'])

        new_song = Song(
            id=song_id,
            artist=artist,
            song_name=song_name,
            hex_code=hex_code,
            song_url=song_res['secure_url'],      # use secure URL
            thumbnail_url=thumbnail_res['secure_url'],
            user_id=auth_data.get("user_id")      # if available
        )
        db.add(new_song)
        db.commit()
        db.refresh(new_song)
        return {
            "status": "success",
            "message": "Song uploaded and saved successfully.",
            "song_id": song_id,
            "song_url": new_song.song_url,
            "thumbnail_url": new_song.thumbnail_url
        }
    except cloudinary.exceptions.Error as e:
        db.rollback()
    
        return {"status": "error", "message": f"Cloudinary upload failed: {str(e)}"}
    except Exception as e:
        db.rollback()
    
        return {"status": "error", "message": f"Unexpected error: {str(e)}"}

#DEFINE GET ROUTE TO FETCH SONGS FROM THE DATABASE AND RETURN THEM AS A LIST OF JSON OBJECTS
@router.get('/', status_code=200)
def get_songs(db: Session = Depends(get_db), auth_details = Depends(auth_middleware)):
    songs = db.query(Song).all()
    return songs
 
