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
exports.checkout = void 0;
const config_1 = require("../config");
const uuid = __importStar(require("uuid"));
const querys_1 = require("../querys");
/**
 * It takes a cart, ownerId, and items, and then creates an order with the items in the cart, and then
 * returns a message saying the order was created
 * @param {any} cart - the cart object
 * @param {string} ownerId - The user id of the user who is making the order
 * @param {any} items - [{id: "", price: 0, quantity: 0}]
 * @returns an object with a statusCode and a body.
 */
function checkout(ownerId, items) {
    return __awaiter(this, void 0, void 0, function* () {
        var total = 0;
        for (const item of items) {
            total += item.price * item.quantity;
        }
        const order = {
            id: uuid.v4(),
            ownerId,
            items,
            createdAt: new Date(Date.now()).getTime() / 1000,
            total: total,
        };
        try {
            yield (0, querys_1.addItem)(config_1.ORDERS_TABLE_NAME, order);
        }
        catch (e) {
            throw e;
        }
        return {
            statuesCode: 200,
            body: { message: "order created" },
        };
    });
}
exports.checkout = checkout;
