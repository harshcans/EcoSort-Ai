from .model import model_builder
import tensorflow as tf 
from tensorflow import keras
from .config import MODEL_PATH
from .evaluate import model_evaluation,plot_history
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

    plot_history(history)
    model_evaluation(model)
    model_saver(model) 



if __name__ == "__main__":
    main()