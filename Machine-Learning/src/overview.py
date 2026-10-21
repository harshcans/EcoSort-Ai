import matplotlib.pyplot as plt
from .data import train_ds,test_ds,val_ds,class_names


plt.figure(figsize=(10, 6))
for images, labels in train_ds.take(1):
    for i in range(12):
        plt.subplot(3, 4, i + 1)
        plt.imshow(images[i].numpy().astype("uint8"))
        plt.title(class_names[labels[i]]); plt.axis("off")
plt.tight_layout(); plt.show()

counts = np.array([len(os.listdir(f"{DATA}/train/{c}")) for c in class_names])
class_weight = {i: float(counts.sum() / (NUM_CLASSES * n)) for i, n in enumerate(counts)}
print(dict(zip(class_names, counts)))
print({class_names[i]: round(w, 2) for i, w in class_weight.items()})