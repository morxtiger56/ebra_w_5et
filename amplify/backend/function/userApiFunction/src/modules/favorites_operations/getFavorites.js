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
exports.getAllFavorites = void 0;
const config_1 = require("./../config");
const querys_1 = require("../querys");
const getProductsImages_1 = require("../products_operations/getProductsImages");
/**
 * It queries the database for all the products that a user has favorited, then it gets the product
 * information for each of those products.
 * @param {string} id - string - the user id
 * @returns An array of arrays of objects.
 */
function getAllFavorites(id) {
    return __awaiter(this, void 0, void 0, function* () {
        var response = [];
        try {
            const res = (yield (0, querys_1.query)({
                tableName: config_1.FAVORITES_TABLE_NAME,
                queryBy: "products_by_user",
                limit: 100,
                fieldName: "userId",
                value: id,
            })).Items;
            if (!res) {
                return {
                    statuesCode: 200,
                    body: [],
                };
            }
            const productRequests = [];
            for (const product of res) {
                productRequests.push({
                    id: product.productId,
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
            for (const request of getRequests) {
                const res = yield (0, querys_1.batchGetItems)(config_1.PRODUCTS_TABLE_NAME, request);
                response.push(...res.Responses[`${config_1.PRODUCTS_TABLE_NAME}`]);
            }
            response = yield (0, getProductsImages_1.getProductsImages)(response);
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
exports.getAllFavorites = getAllFavorites;
