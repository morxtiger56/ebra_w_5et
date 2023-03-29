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
const cognito_1 = require("./modules/cognito");
let response;
const handler = (event, context) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    console.log(`Event: ${JSON.stringify(event, null, 2)}`);
    console.log(`Context: ${JSON.stringify(context, null, 2)}`);
    yield (0, cognito_1.getUserId)();
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
            event.httpMethod === "POST" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== null &&
            event.queryStringParameters.productId:
            response = yield (0, addToFavorites_1.addToFavorites)(event.queryStringParameters.id, event.queryStringParameters.productId);
            break;
        case event.path === "/favorites" &&
            event.httpMethod === "DELETE" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== null &&
            event.queryStringParameters.productId !== null:
            response = yield (0, removeFromFavorites_1.removeFromFavorites)(event.queryStringParameters.id, event.queryStringParameters.productId);
            break;
        case event.path === "/orders" &&
            event.httpMethod === "GET" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== null:
            response = yield (0, getAllOrders_1.getAllOrders)(event.queryStringParameters.id);
            break;
        case event.path === "/orders" &&
            event.httpMethod === "POST" &&
            event.queryStringParameters &&
            event.queryStringParameters.id !== null &&
            event.body !== null:
            response = yield (0, checkout_1.checkout)(event.queryStringParameters.id, event.body);
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
