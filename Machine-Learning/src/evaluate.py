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


def model_evaluation(model):
    loss, acc = model.evaluate(test_ds, verbose=0)
    print(f"Test loss: {loss:.4f} | Test accuracy: {acc:.4f}")

    y_true = np.concatenate([y.numpy() for _, y in test_ds])
    if y_true.ndim > 1:                       # 
        y_true = np.argmax(y_true, axis=1)
    y_pred = np.argmax(model.predict(test_ds, verbose=0), axis=1)

    print(classification_report(y_true, y_pred, target_names=CLASS_NAMES, digits=3))

    cm = confusion_matrix(y_true, y_pred)
    plt.figure(figsize=(10, 8))
    sns.heatmap(cm, annot=True, fmt="d", cmap="Blues",xticklabels=CLASS_NAMES,yticklabels=CLASS_NAMES)
    plt.xlabel("Predicted"); plt.ylabel("True")
    plt.tight_layout(); plt.show()