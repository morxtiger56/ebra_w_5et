import { getObjectUrl } from "../s3_calls";

/**
 * It takes an array of products, and for each product, it gets the images from the database, and then
 * adds the images to the product.
 * @param {any} products - an array of products
 * @returns An array of products with images.
 */
export async function getProductsImages(products: any) {
  const imagesRequests = [];

  for (const product of products) {
    product.images = [];
    imagesRequests.push(getObjectUrl(product.id));
  }

  const responses = await Promise.all(imagesRequests);

  for (const product of products) {
    const images = responses.filter((e) => e.key === product.id);
    if (!images) {
      continue;
    }
    for (const image of images) {
      product.images.push(image.url);
    }
  }

  return products;
}
