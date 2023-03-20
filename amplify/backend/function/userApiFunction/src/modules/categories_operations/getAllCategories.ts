import { CATEGORIES_TABLE_NAME } from "./../config";
import { scan } from "../querys";
import { getProductsImages } from "../products_operations/getProductsImages";

export async function getAllCategories() {
  try {
    var res = (await scan(CATEGORIES_TABLE_NAME, 50)).Items;
    if (!res) {
      return;
    }
    res = await getProductsImages(res);
  } catch (e) {
    throw e;
  }

  return {
    statusCode: 200,
    body: res,
  };
}
