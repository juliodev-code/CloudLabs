output "function_url" {
  value = google_cloudfunctions_function.hello_function.https_trigger_url
}