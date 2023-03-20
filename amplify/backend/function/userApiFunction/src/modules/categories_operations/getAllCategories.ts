import { CATEGORIES_TABLE_NAME } from "./../config";
import { scan } from "../querys";
import { getObjectUrl } from "../s3_calls";

export async function getAllCategories() {
  try {
    var res = (await scan(CATEGORIES_TABLE_NAME, 50)).Items;
    if (!res) {
      return;
    }
    const calls = [];
    for (const cat of res) {
      calls.push(getObjectUrl(cat.key));
    }

    const s3Response = await Promise.all(calls);

    for (const cat of res) {
      cat.image = s3Response.find((e) => e.key === cat.key)?.url;
    }
  } catch (e) {
    throw e;
  }

  return {
    statusCode: 200,
    body: res,
  };
}
