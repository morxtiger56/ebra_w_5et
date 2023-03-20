import { FAVORITES_TABLE_NAME } from "./../config";
import { addItem } from "../querys";

export async function addToFavorites(userId: string, productId: string) {
  const object = {
    userId,
    productId,
    createdAt: new Date(Date.now()).getTime() / 1000,
  };

  try {
    await addItem(FAVORITES_TABLE_NAME, object);
  } catch (e) {
    throw e;
  }

  return {
    statuesCode: 200,
    body: { message: "product added to favorites" },
  };
}
