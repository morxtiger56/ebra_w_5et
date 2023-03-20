import { S3 } from "aws-sdk";
import { BUCKET_NAME } from "./config";

const s3: S3 = new S3();

export async function getObjectUrl(key: string) {
  return {
    url: s3.getSignedUrl("getObject", {
      Bucket: BUCKET_NAME,
      Key: "jacket.png",
      Expires: 60 * 60,
    }),
    number: key,
  };
}
