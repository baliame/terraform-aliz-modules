resource "google_storage_bucket" "function_bucket" {
  name     = var.function_bucket_name
  location = var.function_bucket_location
}

data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = var.function_source_dir
  output_path = "/tmp/${var.function_archive_name}"
}

resource "google_storage_bucket_object" "function_archive" {
  name   = var.function_archive_name
  bucket = google_storage_bucket.function_bucket.name
  source = "/tmp/${var.function_archive_name}"
}

resource "google_cloudfunctions_function" "main" {
  name        = var.function_name
  description = var.function_description
  runtime     = var.function_runtime

  available_memory_mb   = var.function_memory_mb
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_archive.name
  entry_point           = "main"
  service_account_email = google_service_account.function_service_account.email

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.cloudsql_export.id
    failure_policy {
      retry = false
    }
  }
}