import CognitoIdentityServiceProvider from "aws-sdk/clients/cognitoidentityserviceprovider";
import { USER_POOL_ID } from "../config";

export async function modifyUserData(
  userId: string,
  data: any
): Promise<{ statuesCode: number; body: any }> {
  const cognitoISP = new CognitoIdentityServiceProvider({
    region: "us-west-2",
  });
  const userPoolId = USER_POOL_ID;

  const params: CognitoIdentityServiceProvider.AdminUpdateUserAttributesRequest =
    {
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
    await cognitoISP.adminUpdateUserAttributes(params).promise();
    return { statuesCode: 200, body: "user attributes updated" };
  } catch (error) {
    console.log(error);
    return { statuesCode: 400, body: error };
  }
}
