from pathlib import Path 

ROOT = Path(__file__).resolve().parent.parent

ARTIFACTS_DIR = ROOT/"artifacts"

MODEL = ARTIFACTS_DIR/"simple_waste_classifier.jeras"
LABELS = ARTIFACTS_DIR/"class_names.json"

