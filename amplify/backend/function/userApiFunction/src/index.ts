import { Context, APIGatewayProxyResult, APIGatewayEvent } from "aws-lambda";

import { getProducts } from "./modules/getProducts";

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

    default:
      break;
  }

  return {
    statusCode: response!.statuesCode ?? 200,
    body: JSON.stringify(response?.body),
  };
};
