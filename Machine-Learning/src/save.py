import json
from .config import MODEL_PATH
from .data import CLASS_NAMES


def model_saver(model):
    MODEL_PATH.mkdir(parents=True, exist_ok=True)
    model_file = os.path.join(MODEL_PATH, "simple_waste_classifier.keras")
    model.save(model_file)

    with open(MODEL_PATH/"class_names.json","w")as f:
        json.dump(CLASS_NAMES, f)

    print(f"Saved {model_file} and class_names.json")