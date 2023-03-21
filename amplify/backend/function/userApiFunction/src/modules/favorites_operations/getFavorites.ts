import { PRODUCTS_TABLE_NAME } from "./../config";
import { batchGetItems, query } from "../querys";

export async function getAllFavorites(id: string) {
  const response = [];

  try {
    const res = (
      await query({
        tableName: PRODUCTS_TABLE_NAME,
        queryBy: "products_by_user",
        limit: 100,
        fieldName: "userId",
        value: id,
        attToGet: ["productId"],
      })
    ).Items;

    if (!res) {
      return {
        statusCode: 404,
        body: "No favorites found",
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
      response.push(res.Responses![`${PRODUCTS_TABLE_NAME}`]);
    }
  } catch (error) {
    throw error;
  }

  return {
    statusCode: 200,
    body: response,
  };
}
