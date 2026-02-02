# terraform-google-cloud-scheduler

## Description
This module makes it easy to create Google Cloud Scheduler across various regions which can be used to create jobs that can publish a PubSub message or an HTTP request every X interval of time, using a crontab format string It supports creating public, private, forwarding, peering, reverse_lookup and service directory zones.

## Usage

Basic usage of this module is as follows:

```hcl
module "cloud_scheduler" {
  source  = "terraform-google-modules/cloud-scheduler/google"
  version = "~> 0.1"

  project_id  = "<PROJECT ID>"
  bucket_name = "gcs-test-bucket"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_engine\_http\_target | App Engine HTTP target. If the job providers a App Engine HTTP target the cron will send a request to the service instance | <pre>object({<br>    http_method = optional(string)<br>    app_engine_routing = optional(object({<br>      service  = optional(string)<br>      version  = optional(string)<br>      instance = optional(string)<br>    }))<br>    relative_uri = optional(string)<br>    body         = optional(string)<br>    headers = optional(object({<br>      name  = string<br>      value = string<br>    }), null)<br>  })</pre> | `null` | no |
| attempt\_deadline | The deadline for job attempts | `string` | `"15s"` | no |
| description | A human-readable description for the job | `string` | `null` | no |
| http\_target | If the job providers a http\_target the cron will send a request to the targeted url | <pre>object({<br>    uri         = string<br>    http_method = optional(string)<br>    body        = optional(string)<br>    oath_token = optional(object({<br>      service_account_email = string<br>      scope                 = optional(string)<br>    }))<br>    oidc_token = optional(object({<br>      service_account_email = string<br>      audience              = optional(string)<br>    }))<br>  })</pre> | `null` | no |
| location | Region where the scheduler job resides | `string` | n/a | yes |
| name | The name of the job | `string` | n/a | yes |
| paused | Sets the job to a paused state | `bool` | `false` | no |
| project\_id | The project ID to deploy to | `string` | n/a | yes |
| pubsub\_target | Pub/Sub target If the job providers a Pub/Sub target the cron will publish a message to the provided topic | <pre>object({<br>    topic_name = string<br>    data       = optional(string)<br>    attributes = optional(map(string), {})<br>  })</pre> | `null` | no |
| retry\_config | If a job does not complete successfully, then it will be retried with exponential backoff | <pre>object({<br>    retry_count          = optional(number)<br>    max_retry_duration   = optional(string)<br>    min_backoff_duration = optional(string)<br>    max_backoff_duration = optional(string)<br>    max_doublings        = optional(number)<br>  })</pre> | <pre>{<br>  "retry_count": 0<br>}</pre> | no |
| schedule | Schedule on which the job will be executed | `string` | n/a | yes |
| time\_zone | Specifies the time zone to be used in interpreting schedule | `string` | `"UTC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | An identifier for the resource |
| state | State of the job |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
