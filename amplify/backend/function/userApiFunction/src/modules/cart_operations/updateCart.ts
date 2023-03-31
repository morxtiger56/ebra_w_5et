import { CARTS_TABLE_NAME } from "../config";
import { addItem, getItem } from "../querys";

export async function updateCart(
  operation: string,
  item: any,
  cartId: string,
  id: string
) {
  var cart = (await getItem(CARTS_TABLE_NAME, { id: cartId, ownerId: id }))
    .Item;

  if (cart === null || cart === undefined) {
    return {
      statuesCode: 404,
      body: "Cart not found",
    };
  }

  var newCart;
  let data = cart.items as any[];
  let removeId = item;
  newCart = data.filter((obj) => obj.id !== removeId);

  await addItem(CARTS_TABLE_NAME, newCart);
  return {
    statuesCode: 200,
    body: "Cart updated",
  };
}
