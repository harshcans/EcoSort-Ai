Claude


Report · MD
# EcoSort-AI: Waste Classification Model Report
 
An image classifier that sorts waste into 6 categories using transfer learning (EfficientNetB0).
 
| | |
|---|---|
| **Task** | 6-class image classification |
| **Classes** | e-waste, glass, metal, organic, paper, plastic |
| **Test accuracy** | **88.77%** |
| **Test macro F1** | **0.886** |
| **Best validation accuracy** | 91.05% (epoch 22) |
| **Saved model** | `artifact/simple_waste_classifier.keras` (+ `class_names.json`) |
 
---
 
## 1. Dataset
 
| Split | Images |
|-------|-------:|
| Train | 12,438 |
| Validation | 1,553 |
| Test | 1,558 |
 
Images per class:
 
| Class | Train | Val | Test |
|-------|------:|----:|-----:|
| e-waste | 2,124 | 265 | 266 |
| glass | 1,657 | 207 | 208 |
| metal | 1,893 | 236 | 238 |
| organic | 2,400 | 300 | 300 |
| paper | 2,400 | 300 | 300 |
| plastic | 1,964 | 245 | 246 |
 
The dataset is mildly imbalanced (glass has the fewest images, organic and paper the most). The three splits keep roughly the same class proportions.
 
### Class weights
 
To compensate, class weights were applied during training using
`weight = total_samples / (num_classes × class_count)`:
 
| Class | Weight |
|-------|-------:|
| e-waste | 0.98 |
| glass | 1.25 |
| metal | 1.10 |
| organic | 0.86 |
| paper | 0.86 |
| plastic | 1.06 |
 
---
 
## 2. Model Architecture
 
Transfer learning with a **frozen EfficientNetB0 backbone** and a small trainable classification head.
 
| Layer | Output shape | Params |
|-------|--------------|-------:|
| RandomFlip | (224, 224, 3) | 0 |
| RandomRotation | (224, 224, 3) | 0 |
| EfficientNetB0 (frozen) | (7, 7, 1280) | 4,049,571 |
| GlobalAveragePooling2D | (1280) | 0 |
| Dropout | (1280) | 0 |
| Dense (6 outputs) | (6) | 7,686 |
 
- **Total parameters:** 4,057,257 (15.48 MB)
- **Trainable:** 7,686 (30.02 KB), only the final Dense layer
- **Non-trainable:** 4,049,571 (15.45 MB), the frozen backbone
- **Input size:** 224 × 224 × 3
- **Augmentation:** random horizontal/vertical flip and random rotation (active only during training)
---
 
## 3. Training Setup
 
| Setting | Value |
|---------|-------|
| Max epochs | 100 |
| Batch size | 32 (inferred from 389 steps per epoch) |
| Class weighting | Yes (see above) |
| Early stopping | Monitor `val_accuracy`, patience 4, `restore_best_weights=True` |
| Checkpointing | Best `val_accuracy` saved to `best_model.keras` |
| Hardware | CPU only (TensorFlow on native Windows has no GPU support) |
| Time per epoch | ~3.3 to 3.7 minutes |
| Total training time | ~1 h 30 min for 26 epochs |
 
> Optimizer, learning rate and dropout rate are not visible in the logs provided. Add them here if you want the report to be fully reproducible.
 
---
 
## 4. Training Results
 
Training stopped automatically at **epoch 26**. Validation accuracy peaked at epoch 22 and did not improve for the next 4 epochs, so early stopping triggered and the **epoch 22 weights were restored**.
 
| Epoch | Train acc | Val acc | Train loss | Val loss |
|------:|----------:|--------:|-----------:|---------:|
| 1 | 0.7594 | 0.8789 | 0.7274 | 0.3842 |
| 5 | 0.8742 | 0.8989 | 0.3829 | 0.2959 |
| 10 | 0.8804 | 0.9015 | 0.3567 | 0.2811 |
| 15 | 0.8821 | 0.9034 | 0.3476 | 0.2844 |
| 20 | 0.8796 | 0.9086 | 0.3482 | 0.2791 |
| **22 (best)** | **0.8858** | **0.9105** | **0.3368** | **0.2767** |
| 26 (final) | 0.8853 | 0.9028 | 0.3388 | 0.2851 |
 
![Training curves](train_report.png)
 
**Observations**
 
- Most learning happens in the first ~5 epochs; after epoch ~10 the curves are nearly flat.
- Validation accuracy sits *above* training accuracy. This is expected here: dropout and augmentation are active during training but not during validation, and training metrics are averaged over the whole epoch.
- There is no sign of overfitting. The model is limited by capacity (only the final layer is trainable), not by memorizing the training data.
---
 
## 5. Test Results
 
Evaluated on the held-out test set of 1,558 images:
 
| Metric | Value |
|--------|------:|
| Test loss | 0.3082 |
| Test accuracy | **0.8877** |
| Macro avg F1 | 0.886 |
| Weighted avg F1 | 0.888 |
 
The test accuracy is about 2.3 points below the best validation accuracy. This is normal, since the best epoch was chosen using the validation set.
 
### Per-class metrics
 
| Class | Precision | Recall | F1-score | Support |
|-------|----------:|-------:|---------:|--------:|
| e-waste | 0.929 | 0.929 | 0.929 | 266 |
| glass | 0.884 | 0.841 | 0.862 | 208 |
| metal | 0.854 | 0.887 | 0.870 | 238 |
| organic | 0.915 | 0.937 | 0.926 | 300 |
| paper | 0.885 | 0.850 | 0.867 | 300 |
| plastic | 0.849 | 0.870 | 0.859 | 246 |
| **Overall accuracy** | | | **0.888** | **1,558** |
 
- **Strongest classes:** e-waste (F1 0.929) and organic (F1 0.926).
- **Weakest classes:** plastic (F1 0.859), glass (0.862) and paper (0.867).
### Confusion matrix
 
![Confusion matrix](classification_report.png)
 
Counts (rows = true class, columns = predicted class):
 
| True \ Pred | e-waste | glass | metal | organic | paper | plastic |
|-------------|--------:|------:|------:|--------:|------:|--------:|
| **e-waste** | **247** | 2 | 6 | 4 | 6 | 1 |
| **glass** | 3 | **175** | 8 | 3 | 8 | 11 |
| **metal** | 7 | 1 | **211** | 6 | 7 | 6 |
| **organic** | 3 | 5 | 4 | **281** | 3 | 4 |
| **paper** | 6 | 1 | 15 | 7 | **255** | 16 |
| **plastic** | 0 | 14 | 3 | 6 | 9 | **214** |
 

 
## 6. Files
 
| File | Description |
|------|-------------|
| `artifact/simple_waste_classifier.keras` | Final trained model |
| `artifact/class_names.json` | Class label order used by the model |
| `best_model.keras` | Best-validation checkpoint |
| `train_report.png` | Accuracy and loss curves |
| `classification_report.png` | Confusion matrix |
 
