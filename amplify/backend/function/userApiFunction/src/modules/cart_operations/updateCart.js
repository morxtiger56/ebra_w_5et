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
exports.updateCart = void 0;
const config_1 = require("../config");
const querys_1 = require("../querys");
function updateCart(operation, item, cartId, id) {
    return __awaiter(this, void 0, void 0, function* () {
        var cart = (yield (0, querys_1.getItem)(config_1.CARTS_TABLE_NAME, { id: cartId, ownerId: id }))
            .Item;
        if (cart === null || cart === undefined) {
            return {
                statuesCode: 404,
                body: "Cart not found",
            };
        }
        var newCart;
        let data = cart.items;
        let removeId = item;
        newCart = data.filter((obj) => obj.id !== removeId);
        yield (0, querys_1.addItem)(config_1.CARTS_TABLE_NAME, newCart);
        return {
            statuesCode: 200,
            body: "Cart updated",
        };
    });
}
exports.updateCart = updateCart;
