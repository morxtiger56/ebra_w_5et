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
let response;
const handler = (event, context) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    console.log(`Event: ${JSON.stringify(event, null, 2)}`);
    console.log(`Context: ${JSON.stringify(context, null, 2)}`);
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
            event.queryStringParameters.productId:
            response = yield (0, removeFromFavorites_1.removeFromFavorites)(event.queryStringParameters.id, event.queryStringParameters.productId);
            break;
        default:
            break;
    }
    return {
        statusCode: (_a = response.statuesCode) !== null && _a !== void 0 ? _a : 200,
        body: JSON.stringify(response === null || response === void 0 ? void 0 : response.body),
    };
});
exports.handler = handler;
