provider "aws" {
  region     = "your_region"
  access_key = "your_aws_access_id"
  secret_key = "your_aws_secret"
}
resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "atmdfromterra"
  database_name = "default"

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL = "FALSE"
#    "field.delim"            = ","
#    "skip.header.line.count" = "1"
  }

  storage_descriptor {
    location      = "s3://test/atm/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    ser_de_info {
      name                  = "my-serde"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"    
      parameters = {
        "serialization.format" = ","
        "line.delim" = "\n"
        "field.delim"            = ","
        "skip.header.line.count" = "1"
      }
    }


    columns {
      name = "DATE"
      type = "string"
    }

    columns {
      name = "ATM_ID"
      type = "int"
    }

    columns {
      name    = "CLIENT_OUT"
      type    = "int"
    }

  }
}
