import { DynamoDB } from "aws-sdk";
import { DocumentClient } from "aws-sdk/clients/dynamodb";

const documentClient: DynamoDB.DocumentClient = new DynamoDB.DocumentClient();

/**
 * It queries a DynamoDB table by a given field name and value, and returns the results in a promise.
 * @param {string} tableName - The name of the table you want to query
 * @param {string} queryBy - The name of the index you want to query by.
 * @param limit - the number of items to return
 * @param {string} fieldName - The name of the field you want to query by
 * @param {any} value - any,
 * @param {string} [startKey] - The last key from the previous query.
 * @returns The query returns a promise that resolves to an object with the following properties:
 */

export function query(
  tableName: string,
  queryBy: string,
  limit: number,
  fieldName: string,
  value: any,
  startKey: string = ""
) {
  return documentClient
    .query({
      TableName: tableName,
      IndexName: queryBy,
      Limit: limit,
      ScanIndexForward: true,
      KeyConditionExpression: "#5ccb0 = :5ccb0",
      ExclusiveStartKey: startKey
        ? {
            id: startKey,
          }
        : undefined,
      ExpressionAttributeNames: {
        "#5ccb0": fieldName,
      },
      ExpressionAttributeValues: {
        ":5ccb0": value,
      },
    })
    .promise();
}

/**
 * It returns a promise that resolves to the result of a DynamoDB scan operation.
 * @param {string} tableName - The name of the table you want to scan
 * @param {number} limit - The number of items to return.
 * @param {string} [startKey] - The id of the last item in the previous page.
 * @returns A promise that resolves to an object with the following properties:
 */

export function scan(tableName: string, limit: number, startKey: string = "") {
  return documentClient
    .scan({
      TableName: tableName,
      Limit: limit,
      ConsistentRead: true,
      ExclusiveStartKey: startKey
        ? {
            id: startKey,
          }
        : undefined,
    })
    .promise();
}

/**
 * This function gets an item from a DynamoDB table by its id.
 * @param {string} tableName - The name of the table you want to get the item from.
 * @param {string} id - The id of the item you want to get
 * @returns A promise that resolves to an object with the following properties:
 */

export function getItem(tableName: string, id: string) {
  return documentClient
    .get({
      TableName: tableName,
      Key: {
        id: id,
      },
    })
    .promise();
}

/**
 * This function takes a table name and an item, and returns a promise that resolves to the result of
 * putting the item into the table.
 * @param {string} tableName - The name of the table you want to add the item to.
 * @param {any} item - the item to be added to the table
 * @returns A promise.
 */
export function addItem(tableName: string, item: any) {
  return documentClient
    .put({
      TableName: tableName,
      Item: item,
    })
    .promise();
}

export function removeItem(tableName: string, key: DocumentClient.Key) {
  return documentClient
    .delete({
      TableName: tableName,
      Key: key,
    })
    .promise();
}
