import { Context, APIGatewayProxyResult, APIGatewayEvent } from "aws-lambda";

import { getProducts } from "./modules/products_operations/getProducts";
import { removeFromFavorites } from "./modules/favorites_operations/removeFromFavorites";
import { addToFavorites } from "./modules/favorites_operations/addToFavorites";

const PRODUCTS_TABLE_NAME = `products-${process.env.ENV}`;

type CustomResponse = {
  statuesCode: number;
  body: any | string | undefined;
};

let response: CustomResponse | undefined;

export const handler = async (
  event: APIGatewayEvent,
  context: Context
): Promise<APIGatewayProxyResult> => {
  console.log(`Event: ${JSON.stringify(event, null, 2)}`);
  console.log(`Context: ${JSON.stringify(context, null, 2)}`);

  switch (true) {
    case event.path === "/products" &&
      event.httpMethod === "GET" &&
      event.queryStringParameters &&
      event.queryStringParameters.get === "getProducts":
      response = await getProducts(event.body, PRODUCTS_TABLE_NAME);
      break;

    case event.path === "/favorites" &&
      event.httpMethod === "POST" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== null &&
      event.queryStringParameters.productId:
      response = await addToFavorites(
        event.queryStringParameters!.id!,
        event.queryStringParameters!.productId!
      );
      break;

    case event.path === "/favorites" &&
      event.httpMethod === "DELETE" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== null &&
      event.queryStringParameters.productId:
      response = await removeFromFavorites(
        event.queryStringParameters!.id!,
        event.queryStringParameters!.productId!
      );
      break;
    default:
      break;
  }

  return {
    statusCode: response!.statuesCode ?? 200,
    body: JSON.stringify(response?.body),
  };
};
