from pathlib import Path
from .config import  DATA_DIR,IMG,BATCH
import tensorflow as tf, numpy as np
from tensorflow import keras
from tensorflow.keras import layers
from .config import DATA_DIR

DATA = DATA_DIR


for s in ["train", "test", "val"]:
    folder = DATA / s

    assert folder.is_dir(), f"'{s}' folder not found in {DATA.resolve()}"

    counts = {
        c.name: len(list(c.iterdir()))
        for c in sorted(folder.iterdir())
        if c.is_dir()
    }

    print(s, counts)
    

AUTOTUNE = tf.data.AUTOTUNE
train_ds = keras.utils.image_dataset_from_directory(f"{DATA}/train", image_size=IMG, batch_size=BATCH, shuffle=True, seed=42)
val_ds   = keras.utils.image_dataset_from_directory(f"{DATA}/val",   image_size=IMG, batch_size=BATCH, shuffle=False)
test_ds  = keras.utils.image_dataset_from_directory(f"{DATA}/test",  image_size=IMG, batch_size=BATCH, shuffle=False)


CLASS_NAMES = train_ds.class_names
NUM_CLASSES = len(CLASS_NAMES)

print(CLASS_NAMES)
print('GPU:', tf.config.list_physical_devices('GPU') or 'none -> training will run on CPU (slower)')

train_ds = train_ds.prefetch(AUTOTUNE)
val_ds   = val_ds.prefetch(AUTOTUNE)
test_ds  = test_ds.prefetch(AUTOTUNE)