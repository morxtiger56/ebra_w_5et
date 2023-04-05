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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.modifyUserData = void 0;
const cognitoidentityserviceprovider_1 = __importDefault(require("aws-sdk/clients/cognitoidentityserviceprovider"));
const config_1 = require("../config");
function modifyUserData(userId, data) {
    return __awaiter(this, void 0, void 0, function* () {
        const cognitoISP = new cognitoidentityserviceprovider_1.default({
            region: "us-west-2",
        });
        const userPoolId = config_1.USER_POOL_ID;
        const params = {
            UserPoolId: userPoolId,
            Username: userId,
            UserAttributes: [
                { Name: "name", Value: data.name },
                { Name: "address", Value: data.address },
                { Name: "phone_number", Value: data.phoneNumber },
                { Name: "birthdate", Value: data.dateOfBirth },
            ],
        };
        try {
            yield cognitoISP.adminUpdateUserAttributes(params).promise();
            return { statuesCode: 200, body: "user attributes updated" };
        }
        catch (error) {
            console.log(error);
            return { statuesCode: 400, body: error };
        }
    });
}
exports.modifyUserData = modifyUserData;
