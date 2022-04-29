variable "org_id" {
  type        = string
  description = "The organization ID"
}

variable "infra_service_account" {
  type        = string
  description = "The service account used by the infra project."
}

variable "project" {
  type        = string
  description = "The ID of the project to use."
}

variable "region" {
  type        = string
  description = "The region to be used for the function."
}

variable "webhook_secret" {
  type        = string
  description = "The fully qualified ID of the secret where the webhook is stored."
}