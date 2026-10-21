from tensorflow.keras import models,layers
from .data import NUM_CLASSES
import tensorflow as tf 
def model_builder():

    base_model = tf.keras.applications.EfficientNetB0(
        input_shape=(224, 224, 3),
        include_top=False,
        weights='imagenet'
    )
    base_model.trainable = False  

    model = models.Sequential([
        layers.Input(shape=(224, 224, 3)),
        layers.RandomFlip("horizontal"),
        layers.RandomRotation(0.1),
        base_model,
        layers.GlobalAveragePooling2D(),
        layers.Dropout(0.3),
        layers.Dense(NUM_CLASSES, activation='softmax', dtype='float32')
    ])

    model.compile(
        optimizer='adam',
        loss='sparse_categorical_crossentropy',
        metrics=['accuracy']
    )

    model.summary()
    return model