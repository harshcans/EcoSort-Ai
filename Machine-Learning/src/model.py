from tensorflow.keras import models,layers
from .data import NUM_CLASSES
model  = models.Sequential([
    layers.Input(shape=(224, 224, 3)),
    layers.Rescaling(1./255),    
    layers.RandomFlip("horizontal"),
    layers.RandomRotation(0.1),
    layers.RandomZoom(0.1),

    layers.Conv2D(32, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),


    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),


    layers.Conv2D(128, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),


    layers.Flatten(),
    layers.Dense(64, activation='relu'),
    layers.Dropout(0.3),                      
    layers.Dense(NUM_CLASSES, activation='softmax')   
])

model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',metrics=['accuracy'])


model.summary()