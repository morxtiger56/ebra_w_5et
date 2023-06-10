import * as uuid from "uuid";
import { addItem } from "../querys";
import { PRODUCTS_TABLE_NAME } from "../config";

export async function addProduct(body: any) {
  const product = {
    id: uuid.v4(),
    text: body["text"],
    sizes: body["sizes"],
    price: Number(body["price"]),
    images: [""],
    description: body["description"],
    colors: body["colors"],
  };
  console.log(product);
  try {
    await addItem(PRODUCTS_TABLE_NAME, product);
    return {
      statuesCode: 200,
      body: product.id,
    };
  } catch {
    return {
      statuesCode: 500,
      body: "Failed to add Item",
    };
  }
}
