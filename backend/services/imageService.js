
const cloudinary = require("../config/cloudinary");
const { Readable } = require("stream");

function uploadImage(buffer) {
  return new Promise((resolve, reject) => {
    const uploadStream = cloudinary.uploader.upload_stream(
      {
        folder: "ecosort/scans",
        resource_type: "image",
      },
      (error, result) => {
        if (error) {
          return reject(error);
        }

        if (!result || !result.secure_url || !result.public_id) {
          return reject(new Error("Cloudinary returned an invalid result."));
        }

        resolve({
          imageUrl: result.secure_url,
          imagePublicId: result.public_id,
        });
      }
    );

    Readable.from([buffer]).pipe(uploadStream);
  });
}

async function deleteImage(publicId) {
  if (!publicId) {
    throw new Error("Cloudinary public ID is required.");
  }

  const result = await cloudinary.uploader.destroy(publicId, {
    resource_type: "image",
  });

  if (result.result !== "ok" && result.result !== "not found") {
    throw new Error("Cloudinary could not delete the image.");
  }

  return result;
}

module.exports = {
  uploadImage,
  deleteImage,
};
