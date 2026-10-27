import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import classification_report, confusion_matrix
from .data import test_ds, CLASS_NAMES

def plot_history(history):
    fig, ax = plt.subplots(1, 2, figsize=(12, 4))

    ax[0].plot(history.history["accuracy"], label="train")
    ax[0].plot(history.history["val_accuracy"], label="val")
    ax[0].set_title("Accuracy"); ax[0].set_xlabel("epoch"); ax[0].legend()

    ax[1].plot(history.history["loss"], label="train")
    ax[1].plot(history.history["val_loss"], label="val")
    ax[1].set_title("Loss"); ax[1].set_xlabel("epoch"); ax[1].legend()

    plt.tight_layout()
    plt.show()



def model_evaluation(model, test_ds, class_names):
    loss, acc = model.evaluate(test_ds, verbose=0)
    print(f"Test Loss: {loss:.4f} | Test Accuracy: {acc:.4f}\n")
    y_true = tf.concat([y for _, y in test_ds], axis=0).numpy()
    if y_true.ndim > 1:
        y_true = y_true.argmax(axis=1)
    y_pred = model.predict(test_ds, verbose=0).argmax(axis=1)
    print(
        classification_report(y_true, y_pred, target_names=class_names, digits=3))
    fig, ax = plt.subplots(figsize=(8, 6))
    ConfusionMatrixDisplay.from_predictions(y_true,y_pred,display_labels=class_names,cmap="Blues",colorbar=False,ax=ax,)
    plt.tight_layout()
    plt.show()