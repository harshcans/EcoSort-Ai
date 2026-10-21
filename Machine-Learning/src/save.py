def model_saver():
    import json
    from .config import MODEL_PATH
    from .data import CLASS_NAMES
    model.save(f"{MODEL_PATH}/simple_waste_classifier.keras")
    json.dump(CLASS_NAMES, open("class_names.json", "w"))
    print("saved simple_waste_classifier.keras and class_names.json")


