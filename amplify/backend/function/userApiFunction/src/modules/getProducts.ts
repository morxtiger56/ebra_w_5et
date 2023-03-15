import * as queries from "./querys";

export async function getProducts(queryBody: any, tableName: string) {
  let limit = queryBody.limit ?? 20;
  let queryBy = queryBody.queryBy ?? undefined;
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
