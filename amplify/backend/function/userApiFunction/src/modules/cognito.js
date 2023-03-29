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
exports.getUserId = void 0;
const aws_sdk_1 = require("aws-sdk");
const cognitoClient = new aws_sdk_1.CognitoIdentityCredentials({
    IdentityId: "eu-west-1:65c003f3-b36d-4eb7-8b16-e0dc870de10d",
    IdentityPoolId: "eu-west-1:456fff8d-895b-429d-95f1-cc79a52a6e83",
});
function getUserId() {
    return __awaiter(this, void 0, void 0, function* () {
        console.log(cognitoClient.accessKeyId);
    });
}
exports.getUserId = getUserId;
// "eu-west-1:65c003f3-b36d-4eb7-8b16-e0dc870de10d"
