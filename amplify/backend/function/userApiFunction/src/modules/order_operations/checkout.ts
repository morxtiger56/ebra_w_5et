import { CARTS_TABLE_NAME, ORDERS_TABLE_NAME } from "../config";
import * as uuid from "uuid";
import { addItem, updateItem } from "../querys";

/**
 * It takes in an ownerId, cartId, total, and address, and then creates an order object with the given
 * parameters, and then adds the order object to the orders table.
 * @param {string} ownerId - string,
 * @param {any} cartId - the id of the cart that the user is checking out
 * @param {string} total - string,
 * @param {any} address
 * @returns an object with two properties: statuesCode and body.
 */
export async function checkout({
  ownerId,
  cartId,
  total,
  address,
}: {
  ownerId: string;
  cartId: string;
  total: string;
  address: any;
}) {
  await updateItem({
    tableName: CARTS_TABLE_NAME,
    id: {
      id: cartId,
      ownerId: ownerId,
    },
    ExpressionAttributeNames: {
      "#04d60": "address",
      "#04d61": "status",
      "#04d62": "total",
    },
    UpdateExpression: "SET #04d60 = :04d60, #04d61 = :04d61, #04d62 = :04d62",
    values: {
      ":04d60": address,
      ":04d61": "closed",
      ":04d62": total,
    },
  });

  return {
    statuesCode: 200,
    body: { message: "order created" },
  };
}
