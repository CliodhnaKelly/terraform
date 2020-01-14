//# Zip the Lamda function on the fly
//data "archive_file" "source" {
//  type        = "zip"
//  source_dir  = "../lambda-functions/loadbalancer-to-es"
//  output_path = "../lambda-functions/loadbalancer-to-es.zip"
//}
//
//# upload zip to s3 and then update lamda function from s3
//resource "aws_s3_bucket_object" "file_upload" {
//  bucket = "${aws_s3_bucket.bucket.id}"
//  key    = "lambda-functions/loadbalancer-to-es.zip"
//  source = "${data.archive_file.source.output_path}" # its mean it depended on zip
//}
//
//resource "aws_s3_bucket" "bucket" {
//  bucket = "front-end-bucket"
//
//  server_side_encryption_configuration {
//    rule {
//      apply_server_side_encryption_by_default {
//        sse_algorithm = "AES256"
//      }
//    }
//  }
//}