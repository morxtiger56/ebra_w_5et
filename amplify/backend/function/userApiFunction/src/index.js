/* Amplify Params - DO NOT EDIT
	ENV
	REGION
	STORAGE_PRODUCTS_ARN
	STORAGE_PRODUCTS_NAME
	STORAGE_PRODUCTS_STREAMARN
Amplify Params - DO NOT EDIT */"use strict";
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
const getProducts_1 = require("./modules/getProducts");
const PRODUCTS_TABLE_NAME = `products-${process.env.ENV}`;
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
            response = yield (0, getProducts_1.getProducts)(event.body, PRODUCTS_TABLE_NAME);
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
