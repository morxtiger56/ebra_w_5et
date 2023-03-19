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
exports.getObjectUrl = void 0;
const aws_sdk_1 = require("aws-sdk");
const BUCKET_NAME = "ebraw5et058a2e99386f439d978ebd1f93bf685c214445-dev";
const s3 = new aws_sdk_1.S3();
function getObjectUrl(key) {
    return __awaiter(this, void 0, void 0, function* () {
        return {
            url: s3.getSignedUrl("getObject", {
                Bucket: BUCKET_NAME,
                Key: "jacket.png",
                Expires: 60 * 60,
            }),
            number: key,
        };
    });
}
exports.getObjectUrl = getObjectUrl;
