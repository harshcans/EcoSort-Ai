from .model import model_builder
import tensorflow as tf 
from tensorflow import keras
from .config import MODEL_PATH
from .evaluate import model_evaluation
from .overview import overview
from .data import train_ds,test_ds,val_ds
from .overview import CLASS_WEIGHT
from .save import model_saver
import matplotlib.pyplot as plt
import seaborn as sns 

EPOCHS = 100  

def main():
    overview()
    model  = model_builder()
    callbacks = [
        keras.callbacks.ModelCheckpoint("best_model.keras", monitor="val_accuracy", save_best_only=True),
        keras.callbacks.EarlyStopping(monitor="val_accuracy", patience=4, restore_best_weights=True),
    ]
    history = model.fit(train_ds, validation_data=val_ds, epochs=EPOCHS,
    class_weight=CLASS_WEIGHT, callbacks=callbacks)

    fig, ax = plt.subplots(1, 2, figsize=(12, 4))
    ax[0].plot(history.history["accuracy"], label="train")
    ax[0].plot(history.history["val_accuracy"], label="val")
    ax[0].set_title("Accuracy"); ax[0].set_xlabel("epoch"); ax[0].legend()
    ax[1].plot(history.history["loss"], label="train")
    ax[1].plot(history.history["val_loss"], label="val")
    ax[1].set_title("Loss"); ax[1].set_xlabel("epoch"); ax[1].legend()
    plt.show()
    model_evaluation(model)
    model_saver()



if __name__ == "__main__":
    main()