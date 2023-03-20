import { PRODUCTS_TABLE_NAME } from "./../config";
import { query, scan } from "../querys";
import { getProductsImages } from "./getProductsImages";

/**
 * It queries the database for products based on the query parameters passed in the request.
 * @param {any} queryBody - any - this is the body of the request.
 * @returns An object with two properties: statuesCode and body.
 */

export async function getProducts(queryBody: any) {
  let limit = queryBody && queryBody.limit ? queryBody.limit : 20;
  let queryBy = queryBody && queryBody.queryBy ? queryBody.queryBy : undefined;
  let res;

  try {
    if (queryBy) {
      res = (
        await query(
          PRODUCTS_TABLE_NAME,
          `products_by_${queryBy}`,
          limit,
          queryBy,
          queryBody.value
        )
      ).Items;
    } else {
      res = (await scan(PRODUCTS_TABLE_NAME, limit)).Items;
    }
    if (!res) {
      return;
    }
    res = await getProductsImages(res);
  } catch (e) {
    console.error(e);
    throw e;
  }

  return {
    statuesCode: 200,
    body: res,
  };
}
