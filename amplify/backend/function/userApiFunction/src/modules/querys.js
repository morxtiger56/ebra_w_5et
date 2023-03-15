"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getItem = exports.scan = exports.query = void 0;
const aws_sdk_1 = require("aws-sdk");
const documentClient = new aws_sdk_1.DynamoDB.DocumentClient();
function query(tableName, queryBy, limit, fieldName, value, startKey = "") {
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
exports.query = query;
function scan(tableName, limit, startKey = "") {
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
exports.scan = scan;
function getItem(tableName, id) {
    return documentClient
        .get({
        TableName: tableName,
        Key: {
            id: id,
        },
    })
        .promise();
}
exports.getItem = getItem;
