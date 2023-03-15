import * as queries from "./querys";
/**
 * It queries the database for products based on the query parameters passed in the request.
 * @param {any} queryBody - any - this is the body of the request.
 * @param {string} tableName - the name of the table
 * @returns An object with two properties: statuesCode and body.
 */

export async function getProducts(queryBody: any, tableName: string) {
  let limit = queryBody && queryBody.limit ? queryBody.limit : 20;
  let queryBy = queryBody && queryBody.queryBy ? queryBody.queryBy : undefined;
  let res;

  try {
    if (queryBy) {
      res = (
        await queries.query(
          tableName,
          `products_by_${queryBy}`,
          limit,
          queryBy,
          queryBody.value
        )
      ).Items;
    } else {
      res = (await queries.scan(tableName, limit)).Items;
    }
  } catch (e) {
    console.error(e);
    throw e;
  }

  return {
    statuesCode: 200,
    body: res,
  };
}
