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
exports.getProducts = void 0;
const config_1 = require("./../config");
const querys_1 = require("../querys");
const getProductsImages_1 = require("./getProductsImages");
/**
 * It queries the database for products based on the query parameters passed in the request.
 * @param {any} queryBody - any - this is the body of the request.
 * @returns An object with two properties: statuesCode and body.
 */
function getProducts(queryBody) {
    return __awaiter(this, void 0, void 0, function* () {
        let limit = queryBody && queryBody.limit ? queryBody.limit : 20;
        let queryBy = queryBody && queryBody.queryBy ? queryBody.queryBy : undefined;
        let res;
        try {
            if (queryBy) {
                res = (yield (0, querys_1.query)({
                    tableName: config_1.PRODUCTS_TABLE_NAME,
                    queryBy: `products_by_${queryBy}`,
                    limit,
                    fieldName: queryBy,
                    value: queryBody.value,
                })).Items;
            }
            else {
                res = (yield (0, querys_1.scan)(config_1.PRODUCTS_TABLE_NAME, limit)).Items;
            }
            if (!res) {
                return;
            }
            res = yield (0, getProductsImages_1.getProductsImages)(res);
        }
        catch (e) {
            console.error(e);
            throw e;
        }
        return {
            statuesCode: 200,
            body: res,
        };
    });
}
exports.getProducts = getProducts;
