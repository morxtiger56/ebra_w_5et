"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
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
const queries = __importStar(require("./querys"));
/**
 * It queries the database for products based on the query parameters passed in the request.
 * @param {any} queryBody - any - this is the body of the request.
 * @param {string} tableName - the name of the table
 * @returns An object with two properties: statuesCode and body.
 */
function getProducts(queryBody, tableName) {
    return __awaiter(this, void 0, void 0, function* () {
        let limit = queryBody && queryBody.limit ? queryBody.limit : 20;
        let queryBy = queryBody && queryBody.queryBy ? queryBody.queryBy : undefined;
        let res;
        try {
            if (queryBy) {
                res = (yield queries.query(tableName, `products_by_${queryBy}`, limit, queryBy, queryBody.value)).Items;
            }
            else {
                res = (yield queries.scan(tableName, limit)).Items;
            }
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
