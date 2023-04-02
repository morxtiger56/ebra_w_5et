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
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkout = void 0;
const config_1 = require("../config");
const querys_1 = require("../querys");
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
        yield (0, querys_1.updateItem)({
            tableName: config_1.CARTS_TABLE_NAME,
            id: {
                id: cartId,
                ownerId: ownerId,
            },
            ExpressionAttributeNames: {
                "#04d60": "address",
                "#04d61": "status",
                "#04d62": "total",
            },
            UpdateExpression: "SET #04d60 = :04d60, #04d61 = :04d61, #04d62 = :04d62",
            values: {
                ":04d60": address,
                ":04d61": "closed",
                ":04d62": total,
            },
        });
        return {
            statuesCode: 200,
            body: { message: "order created" },
        };
    });
}
exports.checkout = checkout;
