/* Amplify Params - DO NOT EDIT
	AUTH_EBRAW5ET89556DD2_USERPOOLID
	ENV
	REGION
	STORAGE_PRODUCTS_ARN
	STORAGE_PRODUCTS_NAME
	STORAGE_PRODUCTS_STREAMARN
Amplify Params - DO NOT EDIT */

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  return {
    statusCode: 200,
    //  Uncomment below to enable CORS requests
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "*",
    },
    body: JSON.stringify("Hello from Lambda!"),
  };
};
