// Import the `sharp` library
const sharp = require('sharp');
const aws = require('aws-sdk');
const s3 = new aws.s3();

// eslint-disable-next-line
exports.handler = async function (event, context) {
  // If the event type is `delete`, return from the function
  if (event.Records[0].eventName === 'ObjectRemoved:Delete') return;

  // Next, we get the bucket name and the key from the event
  const BUCKET = event.Records[0].s3.bucket.name; //eslint-disable-line
  const KEY = event.Records[0].s3.bucket.key; //eslint-disable-line

  try {
    // Fetch the image data from S3
    let image = await s3.getObject({ Bucket: BUCKET, Key: KEY }).promise();
    image = await sharp(image.Body);

    // Get the metadata from the image, including the width and height
    const metadata = await image.metadata();
    if (metadata.width > 1000) {
      const resizedImage = await image.resize({ width: 1000 }).toBuffer();
      await s3
        .putObject({ Bucket: BUCKET, Body: resizedImage, Key: KEY })
        .promise();
      return;
    } else {
      return;
    }
  } catch (err) {
    context.fail(`Error getting files: ${err}`);
  }
};
