import {
  CARTS_TABLE_NAME,
  ORDERS_TABLE_NAME,
  PRODUCTS_TABLE_NAME,
} from "./../config";
import { batchGetItems, getItem, query } from "../querys";
import { getProductsImages } from "../products_operations/getProductsImages";

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
    for (var order of ordersRes) {
      const res = (
        await getItem(CARTS_TABLE_NAME, {
          id: order.cartId,
          ownerId: id,
        })
      ).Item;

      if (res === null || res === undefined) {
        return {
          statuesCode: 200,
          body: "No carts found",
        };
      }

      const productRequests = [];
      for (const product of res.items) {
        productRequests.push({
          id: product.product,
        });
      }

      const getRequests = [];

      while (productRequests.length > 0) {
        if (productRequests.length > 100) {
          getRequests.push(productRequests.splice(0, 100));
        } else {
          getRequests.push(productRequests.splice(0, productRequests.length));
        }
      }
      let products = [];
      for (const request of getRequests) {
        const res = await batchGetItems(PRODUCTS_TABLE_NAME, request);
        products.push(...res.Responses![`${PRODUCTS_TABLE_NAME}`]);
      }
      products = await getProductsImages(products);
      for (const item of res.items) {
        var product = products.find((e: any) => item.product === e.id);
        item.product = product;
      }
      order.products = res.Items;
    }
  } catch (e) {
    console.log(e);
    return {
      statuesCode: 404,
      body: e,
    };
  }
  return {
    statuesCode: 200,
    body: ordersRes,
  };
}
