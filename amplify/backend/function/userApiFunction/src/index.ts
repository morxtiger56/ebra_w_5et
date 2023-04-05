import { Context, APIGatewayProxyResult, APIGatewayEvent } from "aws-lambda";

import { getProducts } from "./modules/products_operations/getProducts";
import { removeFromFavorites } from "./modules/favorites_operations/removeFromFavorites";
import { addToFavorites } from "./modules/favorites_operations/addToFavorites";
import { getAllOrders } from "./modules/order_operations/getAllOrders";
import { checkout } from "./modules/order_operations/checkout";
import { getAllFavorites } from "./modules/favorites_operations/getFavorites";
import { getOpenCart } from "./modules/cart_operations/getOpenCart";
import { addToCart } from "./modules/cart_operations/addToCart";
import { addAddress } from "./modules/settings_operations/addAddress";
import { modifyUserData } from "./modules/user_operations/modifyUserData";

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
      event.httpMethod === "GET" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== undefined:
      response = await getAllFavorites(event.queryStringParameters!.id!);
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
      event.queryStringParameters.cartId !== undefined &&
      event.queryStringParameters.total !== undefined &&
      event.body !== undefined:
      response = await checkout({
        ownerId: event.queryStringParameters!.id!,
        cartId: event.queryStringParameters!.cartId!,
        total: event.queryStringParameters!.total!,
        address: JSON.parse(event.body!),
      });
      break;

    case event.path === "/cart" &&
      event.httpMethod === "GET" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== undefined:
      response = await getOpenCart(event.queryStringParameters!.id!);
      break;

    case event.path === "/cart" &&
      event.httpMethod === "POST" &&
      event.queryStringParameters &&
      event.queryStringParameters.id !== undefined &&
      event.queryStringParameters.cartId !== undefined &&
      event.body !== undefined:
      response = await addToCart(
        event.queryStringParameters!.id!,
        event.queryStringParameters!.cartId!,
        JSON.parse(event.body!)
      );
      break;

    case event.path === "/settings" &&
      event.httpMethod === "POST" &&
      event.queryStringParameters &&
      event.queryStringParameters.operation === "modify user data" &&
      event.queryStringParameters.id !== undefined &&
      event.body !== undefined:
      response = await modifyUserData(
        event.queryStringParameters!.id!,
        JSON.parse(event.body!)
      );
      break;

    case event.path === "/settings" &&
      event.httpMethod === "POST" &&
      event.queryStringParameters &&
      event.queryStringParameters.operation === "add address" &&
      event.queryStringParameters.id !== undefined &&
      event.body !== undefined:
      response = await addAddress(
        event.queryStringParameters!.id!,
        JSON.parse(event.body!)
      );
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
