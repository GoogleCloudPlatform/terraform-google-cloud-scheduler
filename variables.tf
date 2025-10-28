/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Required variables
variable "name" {
  description = "The name of the job"
  type        = string
}

variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "location" {
  description = "Region where the scheduler job resides"
  type        = string
}

variable "schedule" {
  description = "Schedule on which the job will be executed"
  type        = string
}

# Optional variables
variable "attempt_deadline" {
  description = "The deadline for job attempts"
  type        = string
  default     = "15s"
}

variable "retry_config" {
  description = "If a job does not complete successfully, then it will be retried with exponential backoff"
  type = object({
    retry_count          = optional(number)
    max_retry_duration   = optional(string)
    min_backoff_duration = optional(string)
    max_backoff_duration = optional(string)
    max_doublings        = optional(number)
  })
  default = {
    retry_count = 0
  }
}

variable "description" {
  description = "A human-readable description for the job"
  type        = string
  default     = null
}

variable "time_zone" {
  description = "Specifies the time zone to be used in interpreting schedule"
  type        = string
  default     = "UTC"
}

variable "paused" {
  description = "Sets the job to a paused state"
  type        = bool
  default     = false
}

variable "pubsub_target" {
  description = "Pub/Sub target If the job providers a Pub/Sub target the cron will publish a message to the provided topic"
  type = object({
    topic_name = string
    data       = optional(string)
    attributes = optional(map(string), {})
  })
  default = null
}

variable "app_engine_http_target" {
  description = "App Engine HTTP target. If the job providers a App Engine HTTP target the cron will send a request to the service instance"
  type = object({
    http_method = optional(string)
    app_engine_routing = optional(object({
      service  = optional(string)
      version  = optional(string)
      instance = optional(string)
    }))
    relative_uri = optional(string)
    body         = optional(string)
    headers = optional(object({
      name  = string
      value = string
    }), null)
  })
  default = null
}

variable "http_target" {
  description = "If the job providers a http_target the cron will send a request to the targeted url"
  type = object({
    uri         = string
    http_method = optional(string)
    body        = optional(string)
    oath_token = optional(object({
      service_account_email = string
      scope                 = optional(string)
    }))
    oidc_token = optional(object({
      service_account_email = string
      audience              = optional(string)
    }))
  })
  default = null
}
