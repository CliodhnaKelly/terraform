locals {
  jar_file_name = "crawler-0.0.1-SNAPSHOT.jar"
  jar_file_path = "~/CSC3065/spider-crawler/target/crawler-0.0.1-SNAPSHOT.jar"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "crawler-eb-applicationversion"
}

resource "aws_s3_bucket_object" "s3_bucket_object" {
  bucket = "${aws_s3_bucket.s3_bucket.id}"
  key    = "beanstalk/${local.jar_file_name}"
  source = "${local.jar_file_path}"
}

resource "aws_elastic_beanstalk_application" "eb_app" {
  name        = "crawler-backend"
  depends_on  = ["aws_db_instance.spiderdb"]
  description = "The backend application for the project-cloud project."
}

resource "aws_elastic_beanstalk_application_version" "eb_app_version" {
  name        = "crawler-application-${timestamp()}"
  application = "${aws_elastic_beanstalk_application.eb_app.name}"
  description = "crawler application version created by terraform"
  bucket      = "${aws_s3_bucket.s3_bucket.id}"
  key         = "${aws_s3_bucket_object.s3_bucket_object.key}"

  depends_on = ["aws_elastic_beanstalk_application.eb_app"]

}

resource "aws_elastic_beanstalk_environment" "eb_environment" {
  name                = "crawler-backend-env"
  application         = "${aws_elastic_beanstalk_application.eb_app.name}"
  tier                = "WebServer"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.10.1 running Java 8"
  version_label       = "${aws_elastic_beanstalk_application_version.eb_app_version.name}"


  depends_on = ["aws_elastic_beanstalk_application_version.eb_app_version"]


  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SERVER_PORT"
    value     = "5000"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SPRING_DATASOURCE_URL"
    value     = "jdbc:postgresql://${aws_db_instance.spiderdb.endpoint}/${aws_db_instance.spiderdb.name}?useSSL=false"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SPRING_DATASOURCE_USERNAME"
    value     = "supersecretusername"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SPRING_DATASOURCE_PASSWORD"
    value     = "supersecretpassword"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USERNAME"
    value     = "supersecretusername"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = "supersecretpassword"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_URL"
    value     = "jdbc:postgresql://${aws_db_instance.spiderdb.endpoint}/${aws_db_instance.spiderdb.name}?useSSL=false"
  }
}