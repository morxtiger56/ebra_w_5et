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
exports.getAllCategories = void 0;
const config_1 = require("./../config");
const querys_1 = require("../querys");
const s3_calls_1 = require("../s3_calls");
function getAllCategories() {
    var _a;
    return __awaiter(this, void 0, void 0, function* () {
        try {
            var res = (yield (0, querys_1.scan)(config_1.CATEGORIES_TABLE_NAME, 50)).Items;
            if (!res) {
                return;
            }
            const calls = [];
            for (const cat of res) {
                calls.push((0, s3_calls_1.getObjectUrl)(cat.key));
            }
            const s3Response = yield Promise.all(calls);
            for (const cat of res) {
                cat.image = (_a = s3Response.find((e) => e.key === cat.key)) === null || _a === void 0 ? void 0 : _a.url;
            }
        }
        catch (e) {
            throw e;
        }
        return {
            statusCode: 200,
            body: res,
        };
    });
}
exports.getAllCategories = getAllCategories;
