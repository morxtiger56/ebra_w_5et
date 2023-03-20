import { ItemList } from "aws-sdk/clients/dynamodb";
import { getObjectUrl } from "../s3_calls";

export async function getProductsImages(products: any) {
  const imagesRequests = [];

  for (const product of products) {
    product.images = [];
    imagesRequests.push(getObjectUrl(product.id));
  }

  const responses = await Promise.all(imagesRequests);

  for (const product of products) {
    const images = responses.filter((e) => e.number === product.id);
    if (!images) {
      continue;
    }
    for (const image of images) {
      product.images.push(image.url);
    }
  }

  return products;
}
