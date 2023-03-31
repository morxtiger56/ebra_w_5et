import { FAVORITES_TABLE_NAME, PRODUCTS_TABLE_NAME } from "./../config";
import { batchGetItems, query } from "../querys";
import { getProductsImages } from "../products_operations/getProductsImages";

/**
 * It queries the database for all the products that a user has favorited, then it gets the product
 * information for each of those products.
 * @param {string} id - string - the user id
 * @returns An array of arrays of objects.
 */
export async function getAllFavorites(id: string) {
  var response = [];

  try {
    const res = (
      await query({
        tableName: FAVORITES_TABLE_NAME,
        queryBy: "products_by_user",
        limit: 100,
        fieldName: "userId",
        value: id,
      })
    ).Items;

    if (!res) {
      return {
        statuesCode: 200,
        body: [],
      };
    }

    const productRequests = [];

    for (const product of res) {
      productRequests.push({
        id: product.productId,
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

    for (const request of getRequests) {
      const res = await batchGetItems(PRODUCTS_TABLE_NAME, request);
      response.push(...res.Responses![`${PRODUCTS_TABLE_NAME}`]);
    }
    response = await getProductsImages(response);
  } catch (error) {
    throw error;
  }

  return {
    statuesCode: 200,
    body: response,
  };
}
