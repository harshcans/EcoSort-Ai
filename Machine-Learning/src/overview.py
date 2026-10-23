import matplotlib.pyplot as plt
import numpy as np  
import os 
from .data import train_ds,test_ds,val_ds,CLASS_NAMES,NUM_CLASSES
from .config import DATA_DIR 

DATA = DATA_DIR
counts = np.array([len(list((DATA / "train" / c).iterdir())) for c in CLASS_NAMES])
CLASS_WEIGHT = {i: float(counts.sum() / (NUM_CLASSES * n)) for i, n in enumerate(counts)}
def overview():
    
    plt.figure(figsize=(10, 6))
    for images, labels in train_ds.take(1):
        for i in range(12):
            plt.subplot(3, 4, i + 1)
            plt.imshow(images[i].numpy().astype("uint8"))
            plt.title(CLASS_NAMES[labels[i]]); plt.axis("off")
    plt.tight_layout(); plt.show()
    print(dict(zip(CLASS_NAMES, counts)))
    print({CLASS_NAMES[i]: round(w, 2) for i, w in CLASS_WEIGHT.items()})