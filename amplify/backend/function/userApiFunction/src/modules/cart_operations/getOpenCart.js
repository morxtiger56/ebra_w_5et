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
exports.getOpenCart = void 0;
const config_1 = require("./../config");
const querys_1 = require("../querys");
const getProductsImages_1 = require("../products_operations/getProductsImages");
function getOpenCart(id) {
    return __awaiter(this, void 0, void 0, function* () {
        var response = null;
        try {
            const res = (yield (0, querys_1.query)({
                tableName: config_1.CARTS_TABLE_NAME,
                queryBy: "carts_by_owner",
                fieldName: "ownerId",
                value: id,
                limit: 100,
            })).Items;
            if (res === null || res === undefined) {
                return {
                    statuesCode: 200,
                    body: "No carts found",
                };
            }
            for (const cart of res) {
                if (cart.status == "open") {
                    response = cart;
                }
            }
            if (response === null) {
                return {
                    statuesCode: 200,
                    body: "No open cart found",
                };
            }
            const productRequests = [];
            for (const product of response.items) {
                productRequests.push({
                    id: product.product,
                });
            }
            const getRequests = [];
            while (productRequests.length > 0) {
                if (productRequests.length > 100) {
                    getRequests.push(productRequests.splice(0, 100));
                }
                else {
                    getRequests.push(productRequests.splice(0, productRequests.length));
                }
            }
            let products = [];
            for (const request of getRequests) {
                const res = yield (0, querys_1.batchGetItems)(config_1.PRODUCTS_TABLE_NAME, request);
                products.push(...res.Responses[`${config_1.PRODUCTS_TABLE_NAME}`]);
            }
            products = yield (0, getProductsImages_1.getProductsImages)(products);
            for (const item of response.items) {
                var product = products.find((e) => item.product === e.id);
                item.product = product;
            }
        }
        catch (error) {
            throw error;
        }
        return {
            statuesCode: 200,
            body: response,
        };
    });
}
exports.getOpenCart = getOpenCart;
