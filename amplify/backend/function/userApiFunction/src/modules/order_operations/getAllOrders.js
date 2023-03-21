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
exports.getAllOrders = void 0;
const config_1 = require("./../config");
const querys_1 = require("../querys");
/**
 * It gets all orders for a user, then gets all the products for each order, then returns the orders
 * with the products attached.
 * @param {string} id - string - the id of the user
 * @returns An array of objects.
 */
function getAllOrders(id) {
    return __awaiter(this, void 0, void 0, function* () {
        let ordersRes;
        try {
            ordersRes = (yield (0, querys_1.query)({
                fieldName: "ownerId",
                limit: 3,
                queryBy: "orders_by_owner",
                tableName: config_1.ORDERS_TABLE_NAME,
                value: id,
            })).Items;
            if (!ordersRes) {
                return {
                    statuesCode: 400,
                    body: { message: "no orders found" },
                };
            }
            const getRequest = [];
            for (const item of ordersRes) {
                for (const product of item.items) {
                    getRequest.push({
                        id: product.id,
                    });
                }
            }
            const getRequests = [];
            while (getRequest.length > 0) {
                if (getRequest.length > 100) {
                    getRequests.push(getRequest.splice(0, 100));
                }
                else {
                    getRequests.push(getRequest.splice(0, getRequest.length));
                }
            }
            const products = [];
            for (const request of getRequests) {
                const response = yield (0, querys_1.batchGetItems)(config_1.PRODUCTS_TABLE_NAME, request);
                products.push(response.Responses[`${config_1.PRODUCTS_TABLE_NAME}`]);
            }
            for (const order of ordersRes) {
                order.items.forEach((element) => {
                    element.product = products.find((e) => e.id === element.id);
                });
            }
        }
        catch (e) {
            throw e;
        }
        return {
            statuesCode: 200,
            body: ordersRes,
        };
    });
}
exports.getAllOrders = getAllOrders;
