import { CARTS_TABLE_NAME, ORDERS_TABLE_NAME } from "../config";
import DynamoDB, { DocumentClient } from "aws-sdk/clients/dynamodb";

const documentClient: DynamoDB.DocumentClient = new DynamoDB.DocumentClient();

/**
 * It takes in an ownerId, cartId, total, and address, and then creates an order object with the given
 * parameters, and then adds the order object to the orders table.
 * @param {string} ownerId - string,
 * @param {any} cartId - the id of the cart that the user is checking out
 * @param {string} total - string,
 * @param {any} address
 * @returns an object with two properties: statuesCode and body.
 */
export async function checkout({
  ownerId,
  cartId,
  total,
  address,
}: {
  ownerId: string;
  cartId: string;
  total: string;
  address: any;
}) {
  console.log("here");

  try {
    const response = await documentClient
      .update({
        TableName: CARTS_TABLE_NAME,
        Key: {
          id: cartId,
          ownerId: ownerId,
        },
        UpdateExpression:
          "SET #04d60 = :04d60, #04d61 = :04d61, #04d62 = :04d62",
        ExpressionAttributeNames: {
          "#04d60": "address",
          "#04d61": "status",
          "#04d62": "total",
        },
        ExpressionAttributeValues: {
          ":04d60": address,
          ":04d61": "closed",
          ":04d62": Number(total),
        },
      })
      .promise();

    console.log(response);
  } catch (error) {
    console.log(error);
  }
  return {
    statuesCode: 200,
    body: { message: "order created" },
  };
}
