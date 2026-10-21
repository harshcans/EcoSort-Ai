from .model import model_builder
import tensorflow as tf 
from tensorflow import keras
from .config import MODEL_PATH
from .evaluate import history_plot,model_evaluation
from .overview import overview
from .data import train_ds,test_ds,val_ds
from .overview import CLASS_WEIGHT

EPOCHS = 100  

def main():
    overview()
    model  = model_builder()
    callbacks = [
        keras.callbacks.ModelCheckpoint("best_simple_cnn.keras", monitor="val_accuracy", save_best_only=True),
        keras.callbacks.EarlyStopping(monitor="val_accuracy", patience=4, restore_best_weights=True),
    ]
    history = model.fit(train_ds, validation_data=val_ds, epochs=EPOCHS,
    class_weight=CLASS_WEIGHT, callbacks=callbacks)

    history_plot()
    model_evaluation()


if __name__ == "__main__":
    main()