import { Context, APIGatewayProxyResult, APIGatewayEvent } from "aws-lambda";

import { getProducts } from "./modules/products_operations/getProducts";
import { removeFromFavorites } from "./modules/favorites_operations/removeFromFavorites";
import { addToFavorites } from "./modules/favorites_operations/addToFavorites";
import { getAllOrders } from "./modules/order_operations/getAllOrders";
import { checkout } from "./modules/order_operations/checkout";
import { getUserId } from "./modules/cognito";

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
  await getUserId();
  /* 
  This is a switch statement. 
  It is checks if the checks on multiple parameters in the request. 
  If all of these conditions are true then it will calls the right function and
  pass in the all the required parameters. 
  **/

  switch (true) {
    case event.path === "/products" &&
      event.httpMethod === "GET" &&
      event.queryStringParameters &&
      event.queryStringParameters.get === "getProducts":
      response = await getProducts(event.body);
      break;

    case event.path === "/favorites" &&
      event.httpMethod === "PUT" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== undefined &&
      event.queryStringParameters.productId !== undefined:
      response = await addToFavorites(
        event.queryStringParameters!.id!,
        event.queryStringParameters!.productId!
      );
      break;

    case event.path === "/favorites" &&
      event.httpMethod === "DELETE" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== undefined &&
      event.queryStringParameters.productId !== undefined:
      response = await removeFromFavorites(
        event.queryStringParameters!.id!,
        event.queryStringParameters!.productId!
      );
      break;

    case event.path === "/orders" &&
      event.httpMethod === "GET" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== undefined:
      response = await getAllOrders(event.queryStringParameters!.id!);
      break;

    case event.path === "/orders" &&
      event.httpMethod === "POST" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== undefined &&
      event.body !== undefined:
      response = await checkout(event.queryStringParameters!.id!, event.body);
      break;

    default:
      response = {
        statuesCode: 400,
        body: { message: "no request found" },
      };
      break;
  }

  return {
    statusCode: response!.statuesCode ?? 200,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "*",
    },
    body: JSON.stringify(response?.body),
  };
};
