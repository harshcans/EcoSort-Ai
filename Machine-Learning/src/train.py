from .model import model
import tensorflow as tf 
from .config import MODEL_PATH
from .evaluate import history_plot,model_evaluation

EPOCHS = 100  

def main():
    callbacks = [
        keras.callbacks.ModelCheckpoint("best_simple_cnn.keras", monitor="val_accuracy", save_best_only=True),
        keras.callbacks.EarlyStopping(monitor="val_accuracy", patience=4, restore_best_weights=True),
    ]
    history = model.fit(train_ds, validation_data=val_ds, epochs=EPOCHS,
    class_weight=class_weight, callbacks=callbacks)

    history_plot()
    model_evaluation()


if __name__ == "__main__":
    main()