import { addItem } from "./querys";

export async function addToFavorites(userId: string, productId: string) {
  const object = {
    userId,
    productId,
    createdAt: new Date(Date.now()) / 1000,
  };
}
