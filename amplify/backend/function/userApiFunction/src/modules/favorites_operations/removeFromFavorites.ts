import { FAVORITES_TABLE_NAME } from "./../config";
import { removeItem } from "../querys";

export async function removeFromFavorites(userId: string, productId: string) {
  const object = {
    userId,
    productId,
  };

  try {
    await removeItem(FAVORITES_TABLE_NAME, object);
  } catch (e) {
    throw e;
  }

  return {
    statuesCode: 200,
    body: { message: "product removed from favorites" },
  };
}
