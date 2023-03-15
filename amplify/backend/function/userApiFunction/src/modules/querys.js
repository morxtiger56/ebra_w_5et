"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getItem = exports.scan = exports.query = void 0;
const aws_sdk_1 = require("aws-sdk");
const documentClient = new aws_sdk_1.DynamoDB.DocumentClient();
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
/**
 * It returns a promise that resolves to the result of a DynamoDB scan operation.
 * @param {string} tableName - The name of the table you want to scan
 * @param {number} limit - The number of items to return.
 * @param {string} [startKey] - The id of the last item in the previous page.
 * @returns A promise that resolves to an object with the following properties:
 */
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
/**
 * This function gets an item from a DynamoDB table by its id.
 * @param {string} tableName - The name of the table you want to get the item from.
 * @param {string} id - The id of the item you want to get
 * @returns A promise that resolves to an object with the following properties:
 */
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
