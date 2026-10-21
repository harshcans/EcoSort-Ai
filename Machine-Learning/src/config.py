from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent

DATA_DIR = ROOT / "Data"
TRAIN_DATA = DATA_DIR/"train"
TEST_DATA = DATA_DIR/"test"
VAL_DATA = DATA_DIR/"val"


RANDOM_STATE = 42
IMG = (224, 224)
BATCH = 32
LABELS = {}
MODEL_PATH = ROOT/"artifact"

