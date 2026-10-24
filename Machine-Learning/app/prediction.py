import io
import json
from functools import lru_cache
 
import numpy as np
from PIL import Image, UnidentifiedImageError
from tensorflow import keras
 
from .config import CLASS_NAMES_PATH, IMG_SIZE, MODEL_PATH
 
 
class InvalidImageError(Exception):
    """Raised when the uploaded bytes are not a readable image."""
 
 
@lru_cache(maxsize=1)
def load_model():
    return keras.models.load_model(MODEL_PATH)
 
 
@lru_cache(maxsize=1)
def load_class_names() -> list[str]:
    with open(CLASS_NAMES_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    if isinstance(data, dict):
        if "class_names" in data:
            return list(data["class_names"])
        return [data[k] for k in sorted(data, key=int)]
    return list(data)
 
 
def preprocess(image_bytes: bytes) -> np.ndarray:
    try:
        img = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    except (UnidentifiedImageError, OSError) as exc:
        raise InvalidImageError("File is not a valid image.") from exc
 
    img = img.resize((IMG_SIZE, IMG_SIZE))

    x = np.asarray(img, dtype=np.float32)
    return np.expand_dims(x, axis=0)  
 
 
def predict(image_bytes: bytes) -> tuple[str, float]:
    model = load_model()
    class_names = load_class_names()
 
    x = preprocess(image_bytes)
    probs = model.predict(x, verbose=0)[0]
 
    if not np.isclose(probs.sum(), 1.0, atol=1e-3):
        e = np.exp(probs - probs.max())
        probs = e / e.sum()
 
    idx = int(np.argmax(probs))
    return class_names[idx], float(probs[idx])
 
