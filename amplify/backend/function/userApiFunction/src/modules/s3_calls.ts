import { S3 } from "aws-sdk";

const BUCKET_NAME = "ebraw5et058a2e99386f439d978ebd1f93bf685c214445-dev";
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
