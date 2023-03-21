import { S3 } from "aws-sdk";
import { BUCKET_NAME } from "./config";

const s3: S3 = new S3();

/**
 * It returns a signed URL for an object in an S3 bucket.
 * @param {string} key - The name of the file you want to upload.
 * @returns An object with two properties: url and key.
 */
export async function getObjectUrl(key: string) {
  return {
    url: s3.getSignedUrl("getObject", {
      Bucket: BUCKET_NAME,
      Key: "jacket.png",
      Expires: 60 * 60,
    }),
    key: key,
  };
}
