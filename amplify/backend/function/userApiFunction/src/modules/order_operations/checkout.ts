import { ORDERS_TABLE_NAME } from "../config";
import * as uuid from "uuid";
import { addItem } from "../querys";

/**
 * It takes a cart, ownerId, and items, and then creates an order with the items in the cart, and then
 * returns a message saying the order was created
 * @param {any} cart - the cart object
 * @param {string} ownerId - The user id of the user who is making the order
 * @param {any} items - [{id: "", price: 0, quantity: 0}]
 * @returns an object with a statusCode and a body.
 */
export async function checkout(ownerId: string, cartId: any, total: string) {
  const order = {
    id: uuid.v4(),
    ownerId,
    cartId,
    createdAt: new Date(Date.now()).getTime() / 1000,
    total: Number(total),
  };
  try {
    await addItem(ORDERS_TABLE_NAME, order);
  } catch (e) {
    throw e;
  }

  return {
    statuesCode: 200,
    body: { message: "order created" },
  };
}
