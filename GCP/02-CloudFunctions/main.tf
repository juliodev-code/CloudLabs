terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
      version = "~> 4.83"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "function_bucket" {
  name     = "${var.project_id}-function-bucket"
  location = var.region
}

data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/function"
  output_path = "${path.module}/function.zip"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.function_zip.output_path
}

resource "google_cloudfunctions_function" "hello_function" {
  name        = "terraform-demo-function"
  runtime     = "python39"
  entry_point = "hello_world"

  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  trigger_http = true

  available_memory_mb = 128

  ingress_settings = "ALLOW_ALL"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.hello_function.project
  region         = google_cloudfunctions_function.hello_function.region
  cloud_function = google_cloudfunctions_function.hello_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}