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
exports.handler = void 0;
const getProducts_1 = require("./modules/products_operations/getProducts");
const removeFromFavorites_1 = require("./modules/favorites_operations/removeFromFavorites");
const addToFavorites_1 = require("./modules/favorites_operations/addToFavorites");
const getAllOrders_1 = require("./modules/order_operations/getAllOrders");
const checkout_1 = require("./modules/order_operations/checkout");
const getFavorites_1 = require("./modules/favorites_operations/getFavorites");
const getOpenCart_1 = require("./modules/cart_operations/getOpenCart");
const addToCart_1 = require("./modules/cart_operations/addToCart");
const addAddress_1 = require("./modules/settings_operations/addAddress");
const modifyAddress_1 = require("./modules/settings_operations/modifyAddress");
const getUserData_1 = require("./modules/settings_operations/getUserData");
let response;
const handler = (event, context) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
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
            response = yield (0, getProducts_1.getProducts)(event.body);
            break;
        case event.path === "/favorites" &&
            event.httpMethod === "PUT" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined &&
            event.queryStringParameters.productId !== undefined:
            response = yield (0, addToFavorites_1.addToFavorites)(event.queryStringParameters.id, event.queryStringParameters.productId);
            break;
        case event.path === "/favorites" &&
            event.httpMethod === "GET" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined:
            response = yield (0, getFavorites_1.getAllFavorites)(event.queryStringParameters.id);
            break;
        case event.path === "/favorites" &&
            event.httpMethod === "DELETE" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined &&
            event.queryStringParameters.productId !== undefined:
            response = yield (0, removeFromFavorites_1.removeFromFavorites)(event.queryStringParameters.id, event.queryStringParameters.productId);
            break;
        case event.path === "/orders" &&
            event.httpMethod === "GET" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined:
            response = yield (0, getAllOrders_1.getAllOrders)(event.queryStringParameters.id);
            break;
        case event.path === "/orders" &&
            event.httpMethod === "POST" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined &&
            event.queryStringParameters.cartId !== undefined &&
            event.queryStringParameters.total !== undefined &&
            event.body !== undefined:
            response = yield (0, checkout_1.checkout)({
                ownerId: event.queryStringParameters.id,
                cartId: event.queryStringParameters.cartId,
                total: event.queryStringParameters.total,
                address: JSON.parse(event.body),
            });
            break;
        case event.path === "/cart" &&
            event.httpMethod === "GET" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined:
            response = yield (0, getOpenCart_1.getOpenCart)(event.queryStringParameters.id);
            break;
        case event.path === "/cart" &&
            event.httpMethod === "POST" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined &&
            event.queryStringParameters.cartId !== undefined &&
            event.body !== undefined:
            response = yield (0, addToCart_1.addToCart)(event.queryStringParameters.id, event.queryStringParameters.cartId, JSON.parse(event.body));
            break;
        case event.path === "/settings" &&
            event.httpMethod === "POST" &&
            event.queryStringParameters &&
            event.queryStringParameters.operation === "add address" &&
            event.queryStringParameters.id !== undefined &&
            event.body !== undefined:
            response = yield (0, addAddress_1.addAddress)(event.queryStringParameters.id, JSON.parse(event.body));
            break;
        case event.path === "/settings" &&
            event.httpMethod === "POST" &&
            event.queryStringParameters &&
            event.queryStringParameters.operation === "modify address" &&
            event.queryStringParameters.id !== undefined &&
            event.body !== undefined:
            response = yield (0, modifyAddress_1.modifyAddress)(event.queryStringParameters.id, JSON.parse(event.body));
            break;
        case event.path === "/settings" &&
            event.httpMethod === "GET" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== undefined &&
            event.body !== undefined:
            response = yield (0, getUserData_1.getUserData)(event.queryStringParameters.id);
            break;
        default:
            response = {
                statuesCode: 400,
                body: { message: "no request found" },
            };
            break;
    }
    return {
        statusCode: (_a = response.statuesCode) !== null && _a !== void 0 ? _a : 200,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
        },
        body: JSON.stringify(response === null || response === void 0 ? void 0 : response.body),
    };
});
exports.handler = handler;
