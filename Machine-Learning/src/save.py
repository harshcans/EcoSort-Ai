def model_saver():
    import json
    model.save("simple_waste_classifier.keras")
    json.dump(class_names, open("class_names.json", "w"))
    print("saved simple_waste_classifier.keras and class_names.json")


