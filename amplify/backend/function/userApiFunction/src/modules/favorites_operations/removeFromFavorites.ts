import { FAVORITES_TABLE_NAME } from "./../config";
import { removeItem } from "../querys";

/**
 * It removes a product from the favorites table.
 * @param {string} userId - string,
 * @param {string} productId - string
 * @returns an object with two properties: statuesCode and body.
 */
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
