import { CARTS_TABLE_NAME } from "./../config";
import { addItem, getItem } from "../querys";
import * as uuid from "uuid";

export async function addToCart(id: string, cartId: string, item: any) {
  var cart;
  if (cartId.length > 0) {
    cart = (await getItem(CARTS_TABLE_NAME, { id: cartId, ownerId: id })).Item;
  } else {
    cart = {
      id: uuid.v4(),
      ownerId: id,
      items: [],
      status: "open",
    };
  }

  if (cart === undefined) {
    return {
      statuesCode: 400,
      body: "undefined",
    };
  }

  cart.items.push(item);

  await addItem(CARTS_TABLE_NAME, cart);

  return {
    statuesCode: 200,
    body: cart.id,
  };
}
