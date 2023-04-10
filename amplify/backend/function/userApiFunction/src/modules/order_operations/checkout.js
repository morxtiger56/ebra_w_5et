"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkout = void 0;
const config_1 = require("../config");
const dynamodb_1 = __importDefault(require("aws-sdk/clients/dynamodb"));
const documentClient = new dynamodb_1.default.DocumentClient();
/**
 * It takes in an ownerId, cartId, total, and address, and then creates an order object with the given
 * parameters, and then adds the order object to the orders table.
 * @param {string} ownerId - string,
 * @param {any} cartId - the id of the cart that the user is checking out
 * @param {string} total - string,
 * @param {any} address
 * @returns an object with two properties: statuesCode and body.
 */
function checkout({ ownerId, cartId, total, address, }) {
    return __awaiter(this, void 0, void 0, function* () {
        console.log("here");
        try {
            const response = yield documentClient
                .update({
                TableName: config_1.CARTS_TABLE_NAME,
                Key: {
                    id: cartId,
                    ownerId: ownerId,
                },
                UpdateExpression: "SET #04d60 = :04d60, #04d61 = :04d61, #04d62 = :04d62",
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
        }
        catch (error) {
            console.log(error);
        }
        return {
            statuesCode: 200,
            body: { message: "order created" },
        };
    });
}
exports.checkout = checkout;
