from fastapi import APIRouter
from .prediction import InvalidImageError, predict
from fastapi import FastAPI, UploadFile, File, Form,HTTPException,UploadFile
from .config import ALLOWED_CONTENT_TYPES, MAX_FILE_SIZE_MB
from .schemas import PredictionResponse

router = APIRouter()

 
@router.get("/health")
def health():
    return {"status": "ok"}


@router.post("/predict",response_model=PredictionResponse)
async def upload(file :UploadFile = File(...)):
    if file.content_type not in ALLOWED_CONTENT_TYPES:
        raise HTTPException(
            status_code=415,
            detail=f"Unsupported file type. Use one of: {sorted(ALLOWED_CONTENT_TYPES)}"
        )
    image_bytes = await file.read()
    if len(image_bytes) > MAX_FILE_SIZE_MB * 1024 * 1024:
        raise HTTPException(
            status_code=413, detail=f"File too large (max {MAX_FILE_SIZE_MB} MB)."
        )
    try:
        category, confidence = predict(image_bytes)
    except InvalidImageError as exc:
        raise HTTPException(status_code=400, detail=str(exc))
 
    return PredictionResponse(category=category, confidence=round(confidence, 4))

