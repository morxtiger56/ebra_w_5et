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
exports.removeFromFavorites = void 0;
const config_1 = require("./../config");
const querys_1 = require("../querys");
function removeFromFavorites(userId, productId) {
    return __awaiter(this, void 0, void 0, function* () {
        const object = {
            userId,
            productId,
        };
        try {
            yield (0, querys_1.removeItem)(config_1.FAVORITES_TABLE_NAME, object);
        }
        catch (e) {
            throw e;
        }
        return {
            statuesCode: 200,
            body: { message: "product removed from favorites" },
        };
    });
}
exports.removeFromFavorites = removeFromFavorites;
