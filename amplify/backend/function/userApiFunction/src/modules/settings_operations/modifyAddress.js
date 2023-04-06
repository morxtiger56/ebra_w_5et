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
exports.modifyAddress = void 0;
const config_1 = require("./../config");
const querys_1 = require("../querys");
function modifyAddress(userId, address) {
    return __awaiter(this, void 0, void 0, function* () {
        var user = (yield (0, querys_1.getItem)(config_1.USERS_TABLE_NAME, userId)).Item;
        if (!user) {
            return {
                statuesCode: 404,
                body: "Couldn't find user",
            };
        }
        const index = user.addresses.findIndex((e) => e.id === address.id);
        user.addresses[index] = address;
        yield (0, querys_1.addItem)(config_1.USERS_TABLE_NAME, user);
        return { statuesCode: 200, body: "address saved" };
    });
}
exports.modifyAddress = modifyAddress;
