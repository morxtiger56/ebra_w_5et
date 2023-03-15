import { DynamoDB } from "aws-sdk";

const documentClient: DynamoDB.DocumentClient = new DynamoDB.DocumentClient();

export function query(
  tableName: string,
  queryBy: string,
  limit,
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
      ExclusiveStartKey: {
        id: startKey,
      },
      ExpressionAttributeNames: {
        "#5ccb0": fieldName,
      },
      ExpressionAttributeValues: {
        ":5ccb0": value,
      },
    })
    .promise();
}

export function scan(tableName: string, limit: number, startKey: string = "") {
  return documentClient
    .scan({
      TableName: tableName,
      Limit: limit,
      ConsistentRead: true,
      ExclusiveStartKey: {
        id: startKey,
      },
    })
    .promise();
}
