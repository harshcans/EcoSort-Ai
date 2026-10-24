from pathlib import Path 

ROOT = Path(__file__).resolve().parent.parent

ARTIFACTS_DIR = ROOT/"artifact"

MODEL_PATH = ARTIFACTS_DIR/"simple_waste_classifier.keras"
CLASS_NAMES_PATH = ARTIFACTS_DIR/"class_names.json"

API_TITLE = "Waste Classification API"
API_VERSION = "1.0.0"
IMG_SIZE = 224
ALLOWED_CONTENT_TYPES = {"image/jpeg", "image/png", "image/webp"}
MAX_FILE_SIZE_MB = 10
