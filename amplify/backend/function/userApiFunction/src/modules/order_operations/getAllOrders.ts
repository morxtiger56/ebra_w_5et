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
  var response = null;

  try {
    const res = (
      await query({
        tableName: CARTS_TABLE_NAME,
        queryBy: "carts_by_owner",
        fieldName: "ownerId",
        value: id,
        limit: 100,
      })
    ).Items;

    if (res === null || res === undefined) {
      return {
        statuesCode: 200,
        body: "No carts found",
      };
    }

    for (const cart of res) {
      if (cart.status == "closed") {
        response = cart;
      }
    }

    if (response === null) {
      return {
        statuesCode: 200,
        body: "No open cart found",
      };
    }

    const productRequests = [];
    for (const product of response.items) {
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
    for (const item of response.items) {
      var product = products.find((e: any) => item.product === e.id);
      item.product = product;
    }
  } catch (error) {
    throw error;
  }

  return {
    statuesCode: 200,
    body: response,
  };
}
