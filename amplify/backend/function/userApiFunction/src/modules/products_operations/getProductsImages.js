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
exports.getProductsImages = void 0;
const s3_calls_1 = require("../s3_calls");
function getProductsImages(products) {
    return __awaiter(this, void 0, void 0, function* () {
        const imagesRequests = [];
        for (const product of products) {
            product.images = [];
            imagesRequests.push((0, s3_calls_1.getObjectUrl)(product.id));
        }
        const responses = yield Promise.all(imagesRequests);
        for (const product of products) {
            const images = responses.filter((e) => e.key === product.id);
            if (!images) {
                continue;
            }
            for (const image of images) {
                product.images.push(image.url);
            }
        }
        return products;
    });
}
exports.getProductsImages = getProductsImages;
