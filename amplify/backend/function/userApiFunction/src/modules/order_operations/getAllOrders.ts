import { ORDERS_TABLE_NAME, PRODUCTS_TABLE_NAME } from "./../config";
import { batchGetItems, query } from "../querys";

/**
 * It gets all orders for a user, then gets all the products for each order, then returns the orders
 * with the products attached.
 * @param {string} id - string - the id of the user
 * @returns An array of objects.
 */
export async function getAllOrders(id: string) {
  let ordersRes: any;
  try {
    ordersRes = (
      await query({
        fieldName: "ownerId",
        limit: 3,
        queryBy: "orders_by_owner",
        tableName: ORDERS_TABLE_NAME,
        value: id,
      })
    ).Items;
    if (!ordersRes) {
      return {
        statuesCode: 400,
        body: { message: "no orders found" },
      };
    }
    const getRequest = [];
    for (const item of ordersRes) {
      for (const product of item.items) {
        getRequest.push({
          id: product.id,
        });
      }
    }

    const getRequests = [];

    while (getRequest.length > 0) {
      if (getRequest.length > 100) {
        getRequests.push(getRequest.splice(0, 100));
      } else {
        getRequests.push(getRequest.splice(0, getRequest.length));
      }
    }
    const products: any[] = [];
    for (const request of getRequests) {
      const response = await batchGetItems(PRODUCTS_TABLE_NAME, request);
      products.push(response.Responses![`${PRODUCTS_TABLE_NAME}`]);
    }

    for (const order of ordersRes) {
      order.items.forEach((element: any) => {
        element.product = products.find((e) => e.id === element.id);
      });
    }
  } catch (e) {
    throw e;
  }
  return {
    statuesCode: 200,
    body: ordersRes,
  };
}
