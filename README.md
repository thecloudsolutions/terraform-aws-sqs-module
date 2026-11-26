<!-- markdownlint-disable -->
[![Release](https://img.shields.io/github/v/release/thecloudsolutions/terraform-aws-sqs-module?style=for-the-badge&color=6150E8)](https://github.com/thecloudsolutions/terraform-aws-sqs-module/releases)
[![Commit](https://img.shields.io/github/last-commit/thecloudsolutions/terraform-aws-sqs-module?style=for-the-badge&color=FF9800)](https://github.com/thecloudsolutions/terraform-aws-sqs-module/commits)
[![Issues](https://img.shields.io/github/issues/thecloudsolutions/terraform-aws-sqs-module?style=for-the-badge&color=BB019E)](https://github.com/thecloudsolutions/terraform-aws-sqs-module/issues)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-009FD2?style=for-the-badge)](#requirements)
[![License](https://img.shields.io/github/license/thecloudsolutions/terraform-aws-sqs-module?style=for-the-badge&color=3FB950)](https://github.com/thecloudsolutions/terraform-aws-sqs-module/blob/main/LICENSE)

# terraform-aws-sqs-module

[![Cloud Solutions Banner][banner]](https://thecloudsolutions.com/)

[![Sponsor Us](https://img.shields.io/badge/sponsor_us-FF9800?style=for-the-badge)](https://github.com/sponsors/thecloudsolutions)
[![Hire Us](https://img.shields.io/badge/hire_us-009FD2?style=for-the-badge)](https://thecloudsolutions.com/contact-us)
[![Maintained By](https://img.shields.io/badge/maintained_by-Cloud_Solutions-6150E8?style=for-the-badge)](https://thecloudsolutions.com/)

## Description

Terraform module that provisions Amazon SQS standard and FIFO queues, access policies, and dead-letter queues with configurable redrive policies and permissions. Integrates customer-managed AWS KMS keys for queue encryption and generated IAM policy documents for queue and key access.

## Variable Naming

In all Cloud Solutions **components** and **modules**, we intentionally use the _map suffix for input variables that accept map(object(...)).

For example:
```hcl
variable "sqs_map" {
  type        = map(object({ ... }))
  description = "Keyed collection of sqs definitions"
}
```
⚠️ This is a deliberate deviation from [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/syntax/style).

We fully acknowledge that this naming convention does not follow the Terraform style guide, which recommends naming variables based on what they represent, not how they're implemented. We understand this, and want to emphasize:

1. This is a deliberate, informed decision, not an oversight.
2. Our primary goal is clarity and consistency for developers using our modules.
3. The intent is to give users immediate understanding of what kind of structure they're supplying.

### ✅ Why we made this decision (for our components and modules only)

This convention exists only within our components and modules structure. Here's why it works well for us:

1. Instant clarity for users - The _map suffix immediately signals that the variable supports multiple instances, each keyed by name. This avoids confusion around whether a variable is singular or plural.
2. Uniformity across all resources - Instead of struggling with awkward plurals (like kmses, rdses, vpcs, cloudfronts, account_managements) or inconsistent suffixes (_configs, _definitions, etc.), we use one simple, predictable pattern.
3. Avoids naming collisions - The _map suffix never conflicts with native Terraform or AWS resource types.
4. Future-proof for contributors - When contributors see _map, they can safely assume the structure is a map(object(...)) without checking variables.tf.

### 🙌 What this means for contributors

If you're contributing to Cloud Solutions components or modules, please:

1. Use the _map suffix when introducing a new map(object(...)) variable.
2. Follow the naming pattern consistently: rds_map, vpc_map, cloudfront_map, etc.
3. Don't apply this convention to Terraform projects outside components or modules - it's a local convention, not a global best practice.

If you have strong opinions or ideas for evolving this standard, you're welcome to open a discussion.

## Usage

```hcl
module "terraform-aws-sqs-module" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-sqs-module.git"
  # Cloud Solutions recommends to pin every module to a specific version
  # ?ref=x.x.x

  # Required variables
  sqs_map = {
    key = <value>
  }

  # Optional variables
  kms_map = {
    key = <value>
  }
  iam_map = {
    key = <value>
  }
}
```

> [!IMPORTANT]
> In our examples we don't pin modules to specific versions to keep the documentation aligned with the latest releases.
> However, for your own projects, we recommend to pin each module to the exact version you're using. This approach helps maintain the stability of your infrastructure.
> Additionally, adopting a structured process for version updates will help prevent unexpected changes.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sqs"></a> [sqs](#module\_sqs) | git::https://github.com/thecloudsolutions/terraform-aws-sqs-component.git | main |
| <a name="module_kms"></a> [kms](#module\_kms) | git::https://github.com/thecloudsolutions/terraform-aws-kms-component.git | main |
| <a name="module_iam"></a> [iam](#module\_iam) | git::https://github.com/thecloudsolutions/terraform-aws-iam-component.git | main |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sqs_map"></a> [sqs\_map](#input\_sqs\_map) | Keyed collection of sqs definitions | <pre>map(object({<br/>    queues = optional(map(object({<br/>      region                            = optional(string)<br/>      content_based_deduplication       = optional(bool)<br/>      deduplication_scope               = optional(string)<br/>      delay_seconds                     = optional(number)<br/>      fifo_queue                        = optional(bool)<br/>      fifo_throughput_limit             = optional(string)<br/>      kms_data_key_reuse_period_seconds = optional(number)<br/>      kms_master_key_id                 = optional(string)<br/>      kms_key_custom_name               = optional(string)<br/>      replica_key_custom_name           = optional(string)<br/>      max_message_size                  = optional(number)<br/>      message_retention_seconds         = optional(number)<br/>      name                              = optional(string)<br/>      name_prefix                       = optional(string)<br/>      policy                            = optional(string)<br/>      # (Optional) Inline policy. Do not combine with queue_policies targeting this queue.<br/>      receive_wait_time_seconds = optional(number)<br/>      redrive_allow_policy      = optional(string)<br/>      # (Optional) Inline redrive allow policy. Do not combine with redrive_allow_policies targeting this queue.<br/>      redrive_policy = optional(string)<br/>      # (Optional) Inline redrive policy. Do not combine with redrive_policies targeting this queue.<br/>      sqs_managed_sse_enabled    = optional(bool)<br/>      visibility_timeout_seconds = optional(number)<br/><br/>      timeouts = optional(object({<br/>        create = optional(string)<br/>        update = optional(string)<br/>        delete = optional(string)<br/>      }))<br/><br/>      tags = optional(map(string))<br/>    })), {})<br/><br/>    queue_policies = optional(map(object({<br/>      region = optional(string)<br/>      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.<br/>      policy             = optional(string)<br/>      iam_custom_name    = optional(string)<br/>      policy_custom_name = optional(string)<br/>      queue_url          = optional(string)<br/>      # (Optional) Queue URL. Takes precedence over queue_custom_name.<br/>      queue_custom_name = optional(string)<br/>      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.<br/>    })), {})<br/><br/>    redrive_allow_policies = optional(map(object({<br/>      region = optional(string)<br/>      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.<br/>      queue_url = optional(string)<br/>      # (Optional) Queue URL. Takes precedence over queue_custom_name.<br/>      queue_custom_name = optional(string)<br/>      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.<br/>      redrive_allow_policy = optional(string)<br/>      # (Optional) JSON policy. Takes precedence over the structured policy fields.<br/>      redrive_permission = optional(string)<br/>      # (Optional) Required when redrive_allow_policy is omitted. Valid values are allowAll, denyAll and byQueue.<br/>      source_queue_arns = optional(set(string))<br/>      # (Optional) Source queue ARNs for byQueue. Takes precedence over source_queue_custom_names.<br/>      source_queue_custom_names = optional(set(string), [])<br/>      # (Optional) Source queue keys in queues within this sqs_map entry for byQueue when source_queue_arns is omitted.<br/>    })), {})<br/><br/>    redrive_policies = optional(map(object({<br/>      region = optional(string)<br/>      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.<br/>      queue_url = optional(string)<br/>      # (Optional) Source queue URL. Takes precedence over queue_custom_name.<br/>      queue_custom_name = optional(string)<br/>      # (Optional) Source queue key in queues within this sqs_map entry. Required when queue_url is omitted.<br/>      redrive_policy = optional(string)<br/>      # (Optional) JSON policy. Takes precedence over the structured policy fields.<br/>      dead_letter_target_arn = optional(string)<br/>      # (Optional) Destination queue ARN. Takes precedence over dead_letter_target_custom_name.<br/>      dead_letter_target_custom_name = optional(string)<br/>      # (Optional) Destination queue key in queues within this sqs_map entry. Required when redrive_policy and dead_letter_target_arn are omitted.<br/>      max_receive_count = optional(number)<br/>      # (Optional) Required when redrive_policy is omitted. Number of receives before moving a message to the destination queue.<br/>    })), {})<br/>  }))</pre> | n/a | yes |
| <a name="input_kms_map"></a> [kms\_map](#input\_kms\_map) | Keyed collection of kms definitions | <pre>map(object({<br/>    key = optional(object({<br/>      region                             = optional(string)<br/>      description                        = optional(string)<br/>      key_usage                          = optional(string)<br/>      custom_key_store_id                = optional(string)<br/>      custom_key_store_custom_name       = optional(string)<br/>      customer_master_key_spec           = optional(string)<br/>      policy                             = optional(string)<br/>      iam_custom_name                    = optional(string)<br/>      policy_custom_name                 = optional(string)<br/>      bypass_policy_lockout_safety_check = optional(bool)<br/>      deletion_window_in_days            = optional(number)<br/>      is_enabled                         = optional(bool)<br/>      enable_key_rotation                = optional(bool)<br/>      rotation_period_in_days            = optional(number)<br/>      multi_region                       = optional(bool)<br/>      xks_key_id                         = optional(string)<br/>      tags                               = optional(map(string))<br/>      timeouts = optional(object({<br/>        create = optional(string)<br/>      }))<br/>    }))<br/><br/>    external_key = optional(object({<br/>      region                             = optional(string)<br/>      description                        = optional(string)<br/>      key_spec                           = optional(string)<br/>      key_usage                          = optional(string)<br/>      policy                             = optional(string)<br/>      iam_custom_name                    = optional(string)<br/>      policy_custom_name                 = optional(string)<br/>      bypass_policy_lockout_safety_check = optional(bool)<br/>      deletion_window_in_days            = optional(number)<br/>      enabled                            = optional(bool)<br/>      key_material_base64                = optional(string)<br/>      multi_region                       = optional(bool)<br/>      valid_to                           = optional(string)<br/>      tags                               = optional(map(string))<br/>    }))<br/><br/>    existing_key = optional(object({<br/>      region       = optional(string)<br/>      key_id       = string<br/>      grant_tokens = optional(list(string))<br/>    }))<br/><br/>    aliases = optional(map(object({<br/>      region                  = optional(string)<br/>      name                    = optional(string)<br/>      name_prefix             = optional(string)<br/>      target_key_id           = optional(string)<br/>      replica_key_custom_name = optional(string)<br/>    })), {})<br/><br/>    grants = optional(map(object({<br/>      region                                   = optional(string)<br/>      key_id                                   = optional(string)<br/>      replica_key_custom_name                  = optional(string)<br/>      name                                     = optional(string)<br/>      grantee_principal                        = optional(string)<br/>      grantee_iam_custom_name                  = optional(string)<br/>      grantee_role_custom_name                 = optional(string)<br/>      grantee_user_custom_name                 = optional(string)<br/>      grantee_service_linked_role_custom_name  = optional(string)<br/>      operations                               = set(string)<br/>      retiring_principal                       = optional(string)<br/>      retiring_iam_custom_name                 = optional(string)<br/>      retiring_role_custom_name                = optional(string)<br/>      retiring_user_custom_name                = optional(string)<br/>      retiring_service_linked_role_custom_name = optional(string)<br/>      retire_on_delete                         = optional(bool)<br/>      grant_creation_tokens                    = optional(set(string))<br/>      constraints = optional(set(object({<br/>        encryption_context_equals = optional(map(string))<br/>        encryption_context_subset = optional(map(string))<br/>      })))<br/>    })), {})<br/><br/>    replica_keys = optional(map(object({<br/>      region                             = optional(string)<br/>      primary_key_arn                    = optional(string)<br/>      description                        = optional(string)<br/>      policy                             = optional(string)<br/>      iam_custom_name                    = optional(string)<br/>      policy_custom_name                 = optional(string)<br/>      bypass_policy_lockout_safety_check = optional(bool)<br/>      deletion_window_in_days            = optional(number)<br/>      enabled                            = optional(bool)<br/>      tags                               = optional(map(string))<br/>    })), {})<br/><br/>    replica_external_keys = optional(map(object({<br/>      region                             = optional(string)<br/>      primary_key_arn                    = optional(string)<br/>      description                        = optional(string)<br/>      policy                             = optional(string)<br/>      iam_custom_name                    = optional(string)<br/>      policy_custom_name                 = optional(string)<br/>      bypass_policy_lockout_safety_check = optional(bool)<br/>      deletion_window_in_days            = optional(number)<br/>      enabled                            = optional(bool)<br/>      key_material_base64                = optional(string)<br/>      valid_to                           = optional(string)<br/>      tags                               = optional(map(string))<br/>    })), {})<br/><br/>    key_policy = optional(object({<br/>      region                             = optional(string)<br/>      key_id                             = optional(string)<br/>      policy                             = optional(string)<br/>      iam_custom_name                    = optional(string)<br/>      policy_custom_name                 = optional(string)<br/>      bypass_policy_lockout_safety_check = optional(bool)<br/>    }))<br/><br/>    custom_key_stores = optional(map(object({<br/>      region                   = optional(string)<br/>      custom_key_store_name    = string<br/>      custom_key_store_type    = optional(string)<br/>      cloud_hsm_cluster_id     = optional(string)<br/>      key_store_password       = optional(string)<br/>      trust_anchor_certificate = optional(string)<br/>      xks_proxy_authentication_credential = optional(object({<br/>        access_key_id         = string<br/>        raw_secret_access_key = string<br/>      }))<br/>      xks_proxy_connectivity              = optional(string)<br/>      xks_proxy_uri_endpoint              = optional(string)<br/>      xks_proxy_uri_path                  = optional(string)<br/>      xks_proxy_vpc_endpoint_service_name = optional(string)<br/>      timeouts = optional(object({<br/>        create = optional(string)<br/>        update = optional(string)<br/>        delete = optional(string)<br/>      }))<br/>    })), {})<br/><br/>    public_key = optional(object({<br/>      region                  = optional(string)<br/>      key_id                  = optional(string)<br/>      replica_key_custom_name = optional(string)<br/>      grant_tokens            = optional(list(string))<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_iam_map"></a> [iam\_map](#input\_iam\_map) | Keyed collection of iam definitions | <pre>map(object({<br/>    account_alias = optional(object({<br/>      account_alias = string<br/>    }))<br/><br/>    account_password_policy = optional(object({<br/>      allow_users_to_change_password = optional(bool)<br/>      hard_expiry                    = optional(bool)<br/>      max_password_age               = optional(number)<br/>      minimum_password_length        = optional(number)<br/>      password_reuse_prevention      = optional(number)<br/>      require_lowercase_characters   = optional(bool)<br/>      require_numbers                = optional(bool)<br/>      require_symbols                = optional(bool)<br/>      require_uppercase_characters   = optional(bool)<br/>    }))<br/><br/>    role = optional(object({<br/>      assume_role_policy                      = optional(string)<br/>      assume_role_policy_document_custom_name = optional(string)<br/>      description                             = optional(string)<br/>      force_detach_policies                   = optional(bool)<br/>      inline_policy = optional(set(object({<br/>        name   = string<br/>        policy = string<br/>      })), [])<br/><br/>      managed_policy_arns              = optional(set(string))<br/>      max_session_duration             = optional(number)<br/>      name                             = optional(string)<br/>      name_prefix                      = optional(string)<br/>      path                             = optional(string)<br/>      permissions_boundary             = optional(string)<br/>      permissions_boundary_custom_name = optional(string)<br/><br/>      tags = optional(map(string))<br/>    }))<br/><br/>    policy_documents = optional(map(object({<br/>      override_policy_documents = optional(list(string))<br/>      policy_id                 = optional(string)<br/>      source_policy_documents   = optional(list(string))<br/>      policy_version            = optional(string)<br/><br/>      statement = optional(list(object({<br/>        actions       = optional(set(string))<br/>        effect        = optional(string)<br/>        not_actions   = optional(set(string))<br/>        not_resources = optional(set(string))<br/>        resources     = optional(set(string))<br/>        sid           = optional(string)<br/><br/>        condition = optional(set(object({<br/>          test     = string<br/>          variable = string<br/>          values   = list(any)<br/>        })), [])<br/><br/>        principals = optional(set(object({<br/>          identifiers                = set(string)<br/>          saml_provider_custom_names = optional(set(string), [])<br/>          type                       = string<br/>        })), [])<br/><br/>        not_principals = optional(set(object({<br/>          identifiers                = set(string)<br/>          saml_provider_custom_names = optional(set(string), [])<br/>          type                       = string<br/>        })), [])<br/>      })), [])<br/>    })), {})<br/><br/>    role_policies = optional(map(object({<br/>      name                        = optional(string)<br/>      name_prefix                 = optional(string)<br/>      policy                      = optional(string)<br/>      policy_document_custom_name = optional(string)<br/>      role                        = optional(string)<br/>    })), {})<br/><br/>    role_policy_attachments = optional(list(object({<br/>      custom_name        = optional(string)<br/>      policy_arn         = optional(string)<br/>      policy_custom_name = optional(string)<br/>      role               = optional(string)<br/>    })), [])<br/><br/>    role_policies_exclusive = optional(object({<br/>      role_name           = optional(string)<br/>      policy_names        = set(string)<br/>      policy_custom_names = optional(set(string), [])<br/>    }))<br/><br/>    instance_profile = optional(object({<br/>      name        = optional(string)<br/>      name_prefix = optional(string)<br/>      path        = optional(string)<br/>      role        = optional(string)<br/>      tags        = optional(map(string))<br/>    }))<br/><br/>    policy_attachments_exclusive = optional(object({<br/>      policy_arns         = set(string)<br/>      policy_custom_names = optional(set(string), [])<br/>      role_name           = optional(string)<br/>    }))<br/><br/>    policies = optional(map(object({<br/>      policy                            = optional(string)<br/>      policy_custom_name                = optional(string)<br/>      delay_after_policy_creation_in_ms = optional(number)<br/>      description                       = optional(string)<br/>      name                              = optional(string)<br/>      name_prefix                       = optional(string)<br/>      path                              = optional(string)<br/>      tags                              = optional(map(string))<br/>    })), {})<br/><br/>    users = optional(map(object({<br/>      name                             = string<br/>      path                             = optional(string)<br/>      permissions_boundary             = optional(string)<br/>      permissions_boundary_custom_name = optional(string)<br/>      force_destroy                    = optional(bool)<br/>      tags                             = optional(map(string))<br/>    })), {})<br/><br/>    user_login_profiles = optional(map(object({<br/>      user                    = optional(string)<br/>      user_custom_name        = optional(string)<br/>      pgp_key                 = optional(string)<br/>      password_length         = optional(number)<br/>      password_reset_required = optional(bool)<br/>    })), {})<br/><br/>    access_keys = optional(map(object({<br/>      user             = optional(string)<br/>      user_custom_name = optional(string)<br/>      pgp_key          = optional(string)<br/>      status           = optional(string)<br/>    })), {})<br/><br/>    user_ssh_keys = optional(map(object({<br/>      username         = optional(string)<br/>      user_custom_name = optional(string)<br/>      encoding         = string<br/>      public_key       = string<br/>      status           = optional(string)<br/>    })), {})<br/><br/>    groups = optional(map(object({<br/>      name = string<br/>      path = optional(string)<br/>    })), {})<br/><br/>    user_policies = optional(map(object({<br/>      name                        = optional(string)<br/>      name_prefix                 = optional(string)<br/>      policy                      = optional(string)<br/>      policy_document_custom_name = optional(string)<br/>      user                        = optional(string)<br/>      user_custom_name            = optional(string)<br/>    })), {})<br/><br/>    user_policy_attachments = optional(map(object({<br/>      user               = optional(string)<br/>      user_custom_name   = optional(string)<br/>      policy_arn         = optional(string)<br/>      policy_custom_name = optional(string)<br/>    })), {})<br/><br/>    user_policies_exclusive = optional(map(object({<br/>      user_name           = optional(string)<br/>      user_custom_name    = optional(string)<br/>      policy_names        = set(string)<br/>      policy_custom_names = optional(set(string), [])<br/>    })), {})<br/><br/>    user_policy_attachments_exclusive = optional(map(object({<br/>      user_name           = optional(string)<br/>      user_custom_name    = optional(string)<br/>      policy_arns         = set(string)<br/>      policy_custom_names = optional(set(string), [])<br/>    })), {})<br/><br/>    group_policies = optional(map(object({<br/>      name                        = optional(string)<br/>      name_prefix                 = optional(string)<br/>      policy                      = optional(string)<br/>      policy_document_custom_name = optional(string)<br/>      group                       = optional(string)<br/>      group_custom_name           = optional(string)<br/>    })), {})<br/><br/>    group_policy_attachments = optional(map(object({<br/>      group              = optional(string)<br/>      group_custom_name  = optional(string)<br/>      policy_arn         = optional(string)<br/>      policy_custom_name = optional(string)<br/>    })), {})<br/><br/>    group_policies_exclusive = optional(map(object({<br/>      group_name          = optional(string)<br/>      group_custom_name   = optional(string)<br/>      policy_names        = set(string)<br/>      policy_custom_names = optional(set(string), [])<br/>    })), {})<br/><br/>    group_policy_attachments_exclusive = optional(map(object({<br/>      group_name          = optional(string)<br/>      group_custom_name   = optional(string)<br/>      policy_arns         = set(string)<br/>      policy_custom_names = optional(set(string), [])<br/>    })), {})<br/><br/>    group_memberships = optional(map(object({<br/>      name              = string<br/>      users             = set(string)<br/>      user_custom_names = optional(set(string), [])<br/>      group             = optional(string)<br/>      group_custom_name = optional(string)<br/>    })), {})<br/><br/>    user_group_memberships = optional(map(object({<br/>      user   = optional(string)<br/>      groups = optional(set(string), [])<br/>    })), {})<br/><br/>    openid_connect_providers = optional(map(object({<br/>      url             = string<br/>      client_id_list  = set(string)<br/>      thumbprint_list = optional(list(string))<br/>      tags            = optional(map(string))<br/>    })), {})<br/><br/>    saml_providers = optional(map(object({<br/>      name                   = string<br/>      saml_metadata_document = string<br/>      tags                   = optional(map(string))<br/>    })), {})<br/><br/>    service_linked_roles = optional(map(object({<br/>      aws_service_name = string<br/>      custom_suffix    = optional(string)<br/>      description      = optional(string)<br/>      tags             = optional(map(string))<br/>    })), {})<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sqs_queue_arns"></a> [sqs\_queue\_arns](#output\_sqs\_queue\_arns) | ARNs of the SQS queues, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_ids"></a> [sqs\_queue\_ids](#output\_sqs\_queue\_ids) | URLs of the SQS queues, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_urls"></a> [sqs\_queue\_urls](#output\_sqs\_queue\_urls) | URLs of the SQS queues, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_tags_all"></a> [sqs\_queue\_tags\_all](#output\_sqs\_queue\_tags\_all) | Tags assigned to the queues, including provider default tags, keyed by SQS definition and queue. |
| <a name="output_sqs_queue_names"></a> [sqs\_queue\_names](#output\_sqs\_queue\_names) | Names of the SQS queues, keyed by SQS definition and queue. |
| <a name="output_kms_key_arns"></a> [kms\_key\_arns](#output\_kms\_key\_arns) | The Amazon Resource Name (ARN) of the key. |
| <a name="output_kms_key_ids"></a> [kms\_key\_ids](#output\_kms\_key\_ids) | The globally unique identifier for the key. |
| <a name="output_kms_key_tags_all"></a> [kms\_key\_tags\_all](#output\_kms\_key\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_kms_alias_arns"></a> [kms\_alias\_arns](#output\_kms\_alias\_arns) | The Amazon Resource Name (ARN) of the key alias. |
| <a name="output_kms_alias_target_key_arns"></a> [kms\_alias\_target\_key\_arns](#output\_kms\_alias\_target\_key\_arns) | The Amazon Resource Name (ARN) of the target key identifier. |
| <a name="output_kms_key_regions"></a> [kms\_key\_regions](#output\_kms\_key\_regions) | Regions where the keys are managed. |
| <a name="output_kms_key_policies"></a> [kms\_key\_policies](#output\_kms\_key\_policies) | Map of key policy JSON documents. |
| <a name="output_kms_key_specs"></a> [kms\_key\_specs](#output\_kms\_key\_specs) | Types of key material. |
| <a name="output_kms_key_usages"></a> [kms\_key\_usages](#output\_kms\_key\_usages) | Permitted cryptographic uses of the keys. |
| <a name="output_kms_key_states"></a> [kms\_key\_states](#output\_kms\_key\_states) | States of imported and existing keys. |
| <a name="output_kms_key_expiration_models"></a> [kms\_key\_expiration\_models](#output\_kms\_key\_expiration\_models) | Whether imported key material expires. |
| <a name="output_kms_key_valid_to"></a> [kms\_key\_valid\_to](#output\_kms\_key\_valid\_to) | Expiration times of imported key material. |
| <a name="output_kms_alias_names"></a> [kms\_alias\_names](#output\_kms\_alias\_names) | Names of the key aliases. |
| <a name="output_kms_alias_name_prefixes"></a> [kms\_alias\_name\_prefixes](#output\_kms\_alias\_name\_prefixes) | Prefixes used to generate the alias names. |
| <a name="output_kms_alias_target_key_ids"></a> [kms\_alias\_target\_key\_ids](#output\_kms\_alias\_target\_key\_ids) | Identifiers of the keys associated with the aliases. |
| <a name="output_kms_alias_regions"></a> [kms\_alias\_regions](#output\_kms\_alias\_regions) | Regions where the aliases are managed. |
| <a name="output_kms_grant_ids"></a> [kms\_grant\_ids](#output\_kms\_grant\_ids) | Maps of grant identifiers. |
| <a name="output_kms_grant_tokens"></a> [kms\_grant\_tokens](#output\_kms\_grant\_tokens) | Maps of grant tokens. |
| <a name="output_kms_grant_regions"></a> [kms\_grant\_regions](#output\_kms\_grant\_regions) | Maps of grant regions. |
| <a name="output_kms_grant_key_ids"></a> [kms\_grant\_key\_ids](#output\_kms\_grant\_key\_ids) | Maps of key IDs or ARNs to which the grants apply. |
| <a name="output_kms_grant_names"></a> [kms\_grant\_names](#output\_kms\_grant\_names) | Maps of grant names. |
| <a name="output_kms_grant_grantee_principals"></a> [kms\_grant\_grantee\_principals](#output\_kms\_grant\_grantee\_principals) | Maps of grantee principals. |
| <a name="output_kms_grant_operations"></a> [kms\_grant\_operations](#output\_kms\_grant\_operations) | Maps of operations permitted by the grants. |
| <a name="output_kms_grant_retiring_principals"></a> [kms\_grant\_retiring\_principals](#output\_kms\_grant\_retiring\_principals) | Maps of retiring principals. |
| <a name="output_kms_grant_constraints"></a> [kms\_grant\_constraints](#output\_kms\_grant\_constraints) | Maps of encryption context constraints for the grants. |
| <a name="output_kms_replica_key_arns"></a> [kms\_replica\_key\_arns](#output\_kms\_replica\_key\_arns) | The Amazon Resource Name (ARN) of the key. |
| <a name="output_kms_replica_key_ids"></a> [kms\_replica\_key\_ids](#output\_kms\_replica\_key\_ids) | The globally unique identifier for the key. |
| <a name="output_kms_replica_key_regions"></a> [kms\_replica\_key\_regions](#output\_kms\_replica\_key\_regions) | Region where the resource is managed. |
| <a name="output_kms_replica_key_policies"></a> [kms\_replica\_key\_policies](#output\_kms\_replica\_key\_policies) | The key policy JSON document. |
| <a name="output_kms_replica_key_rotation_enabled"></a> [kms\_replica\_key\_rotation\_enabled](#output\_kms\_replica\_key\_rotation\_enabled) | Whether rotation is enabled for the related multi-Region keys. |
| <a name="output_kms_replica_key_specs"></a> [kms\_replica\_key\_specs](#output\_kms\_replica\_key\_specs) | Type of key material. |
| <a name="output_kms_replica_key_usages"></a> [kms\_replica\_key\_usages](#output\_kms\_replica\_key\_usages) | Permitted cryptographic use of the key. |
| <a name="output_kms_replica_key_enabled"></a> [kms\_replica\_key\_enabled](#output\_kms\_replica\_key\_enabled) | Whether the key is enabled. |
| <a name="output_kms_replica_key_tags_all"></a> [kms\_replica\_key\_tags\_all](#output\_kms\_replica\_key\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_kms_replica_external_key_arns"></a> [kms\_replica\_external\_key\_arns](#output\_kms\_replica\_external\_key\_arns) | The Amazon Resource Name (ARN) of the key. |
| <a name="output_kms_replica_external_key_ids"></a> [kms\_replica\_external\_key\_ids](#output\_kms\_replica\_external\_key\_ids) | The globally unique identifier for the key. |
| <a name="output_kms_replica_external_key_regions"></a> [kms\_replica\_external\_key\_regions](#output\_kms\_replica\_external\_key\_regions) | Region where the resource is managed. |
| <a name="output_kms_replica_external_key_policies"></a> [kms\_replica\_external\_key\_policies](#output\_kms\_replica\_external\_key\_policies) | The key policy JSON document. |
| <a name="output_kms_replica_external_key_usages"></a> [kms\_replica\_external\_key\_usages](#output\_kms\_replica\_external\_key\_usages) | Permitted cryptographic use of the key. |
| <a name="output_kms_replica_external_key_states"></a> [kms\_replica\_external\_key\_states](#output\_kms\_replica\_external\_key\_states) | The current state of the key. |
| <a name="output_kms_replica_external_key_expiration_models"></a> [kms\_replica\_external\_key\_expiration\_models](#output\_kms\_replica\_external\_key\_expiration\_models) | Whether the imported key material expires. |
| <a name="output_kms_replica_external_key_valid_to"></a> [kms\_replica\_external\_key\_valid\_to](#output\_kms\_replica\_external\_key\_valid\_to) | Expiration time of the imported key material. |
| <a name="output_kms_replica_external_key_enabled"></a> [kms\_replica\_external\_key\_enabled](#output\_kms\_replica\_external\_key\_enabled) | Whether the key is enabled. |
| <a name="output_kms_replica_external_key_tags_all"></a> [kms\_replica\_external\_key\_tags\_all](#output\_kms\_replica\_external\_key\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_kms_custom_key_store_ids"></a> [kms\_custom\_key\_store\_ids](#output\_kms\_custom\_key\_store\_ids) | Maps of custom key store identifiers. |
| <a name="output_kms_existing_key_ids"></a> [kms\_existing\_key\_ids](#output\_kms\_existing\_key\_ids) | The unique identifier of the resource. |
| <a name="output_kms_existing_key_arns"></a> [kms\_existing\_key\_arns](#output\_kms\_existing\_key\_arns) | The Amazon Resource Name (ARN) of the key. |
| <a name="output_kms_existing_key_regions"></a> [kms\_existing\_key\_regions](#output\_kms\_existing\_key\_regions) | Region where the resource is managed. |
| <a name="output_kms_existing_key_aws_account_ids"></a> [kms\_existing\_key\_aws\_account\_ids](#output\_kms\_existing\_key\_aws\_account\_ids) | AWS account that owns the key. |
| <a name="output_kms_existing_key_cloud_hsm_cluster_ids"></a> [kms\_existing\_key\_cloud\_hsm\_cluster\_ids](#output\_kms\_existing\_key\_cloud\_hsm\_cluster\_ids) | CloudHSM cluster containing the key material. |
| <a name="output_kms_existing_key_creation_dates"></a> [kms\_existing\_key\_creation\_dates](#output\_kms\_existing\_key\_creation\_dates) | Creation date of the key. |
| <a name="output_kms_existing_key_custom_key_store_ids"></a> [kms\_existing\_key\_custom\_key\_store\_ids](#output\_kms\_existing\_key\_custom\_key\_store\_ids) | ID of the custom key store containing the key. |
| <a name="output_kms_existing_key_customer_master_key_specs"></a> [kms\_existing\_key\_customer\_master\_key\_specs](#output\_kms\_existing\_key\_customer\_master\_key\_specs) | Type of key material. |
| <a name="output_kms_existing_key_deletion_dates"></a> [kms\_existing\_key\_deletion\_dates](#output\_kms\_existing\_key\_deletion\_dates) | Scheduled deletion date of the key. |
| <a name="output_kms_existing_key_descriptions"></a> [kms\_existing\_key\_descriptions](#output\_kms\_existing\_key\_descriptions) | Description of the key. |
| <a name="output_kms_existing_key_enabled"></a> [kms\_existing\_key\_enabled](#output\_kms\_existing\_key\_enabled) | Whether the key is enabled. |
| <a name="output_kms_existing_key_expiration_models"></a> [kms\_existing\_key\_expiration\_models](#output\_kms\_existing\_key\_expiration\_models) | Whether the imported key material expires. |
| <a name="output_kms_existing_key_managers"></a> [kms\_existing\_key\_managers](#output\_kms\_existing\_key\_managers) | Manager of the key. |
| <a name="output_kms_existing_key_specs"></a> [kms\_existing\_key\_specs](#output\_kms\_existing\_key\_specs) | Type of key material. |
| <a name="output_kms_existing_key_states"></a> [kms\_existing\_key\_states](#output\_kms\_existing\_key\_states) | The current state of the key. |
| <a name="output_kms_existing_key_usages"></a> [kms\_existing\_key\_usages](#output\_kms\_existing\_key\_usages) | Permitted cryptographic use of the key. |
| <a name="output_kms_existing_key_multi_region"></a> [kms\_existing\_key\_multi\_region](#output\_kms\_existing\_key\_multi\_region) | Whether the key is a multi-Region key. |
| <a name="output_kms_existing_key_multi_region_configurations"></a> [kms\_existing\_key\_multi\_region\_configurations](#output\_kms\_existing\_key\_multi\_region\_configurations) | Primary and replica configuration of the multi-Region key. |
| <a name="output_kms_existing_key_origins"></a> [kms\_existing\_key\_origins](#output\_kms\_existing\_key\_origins) | Origin of the key material. |
| <a name="output_kms_existing_key_pending_deletion_window_in_days"></a> [kms\_existing\_key\_pending\_deletion\_window\_in\_days](#output\_kms\_existing\_key\_pending\_deletion\_window\_in\_days) | Waiting period before deleting a multi-Region primary key. |
| <a name="output_kms_existing_key_valid_to"></a> [kms\_existing\_key\_valid\_to](#output\_kms\_existing\_key\_valid\_to) | Expiration time of the imported key material. |
| <a name="output_kms_existing_key_xks_key_configurations"></a> [kms\_existing\_key\_xks\_key\_configurations](#output\_kms\_existing\_key\_xks\_key\_configurations) | Configuration of the external key store key. |
| <a name="output_kms_public_keys"></a> [kms\_public\_keys](#output\_kms\_public\_keys) | Base64-encoded DER public keys. |
| <a name="output_kms_public_key_pems"></a> [kms\_public\_key\_pems](#output\_kms\_public\_key\_pems) | PEM-encoded public keys. |
| <a name="output_kms_public_key_arns"></a> [kms\_public\_key\_arns](#output\_kms\_public\_key\_arns) | ARNs of keys whose public keys were retrieved. |
| <a name="output_kms_public_key_encryption_algorithms"></a> [kms\_public\_key\_encryption\_algorithms](#output\_kms\_public\_key\_encryption\_algorithms) | Encryption algorithms supported by the keys. |
| <a name="output_kms_public_key_signing_algorithms"></a> [kms\_public\_key\_signing\_algorithms](#output\_kms\_public\_key\_signing\_algorithms) | Signing algorithms supported by the keys. |
| <a name="output_iam_policy_document_jsons"></a> [iam\_policy\_document\_jsons](#output\_iam\_policy\_document\_jsons) | Standard JSON policy document rendered based on the arguments above. |

## Quick Start

The project is under active development, and we welcome all contributors! 🎉
  
Before you start, please review our [Contributor Guidelines](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) to understand the expectations and processes.
  
Follow these steps to get started:
  
---
  
### 1. **Fork the Repository**
- Click the **"Fork"** button on the repository's GitHub page to create a copy under your GitHub account.

> [!TIP]
> If you're new to GitHub, check out the [GitHub Docs](https://docs.github.com/en/get-started) to familiarize yourself with key concepts like forking, branching, and pull requests.
  
### 2. **Clone the Fork**
- Clone your fork to your local machine using:
  ```bash
  git clone https://github.com/<your-username>/<repository-name>.git
  ```
  
### 3. **Create a Branch**
- Create a new branch for your contribution:
  ```bash
  git checkout -b your-feature-name
  ```
  
### 4. **Make Changes**
- Implement your changes in the codebase.
- Ensure you follow the project's style guide and standards.
  
> [!WARNING]
> Always adhere to the project's coding standards and best practices outlined in the [CONTRIBUTING.md](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) file.
    
### 5. **Test Your Changes**
- Run tests to verify your changes locally.
- Follow any project-specific testing instructions.
    
### 6. **Commit Your Changes**
- Stage and commit your changes with a clear and concise message:
  ```bash
  git add .
  git commit -m "Add description of the change"
  ```

> [!NOTE]
> Use meaningful commit messages in the present tense (e.g., "Add feature X" instead of "Added feature X").
  
### 7. **Push Your Branch**
- Push your branch to your fork:
  ```bash
  git push origin your-feature-name
  ```
    
### 8. **Open a Pull Request (PR)**
- Navigate to the original repository and click the **"New Pull Request"** button.
- Select your branch and submit your PR following the [Pull Request template](https://github.com/thecloudsolutions/.github/blob/main/.github/PULL_REQUEST_TEMPLATE/pull_request_template.md).
- Use keywords like `Closes #123` to link your PR to a related issue.
  
### **🎉 Congratulations, you’ve made your first contribution! 🎉**  
We appreciate your effort and look forward to reviewing your work.

## About Us

**Cloud Solutions: Innovating Open Source for AWS & DevOps**

Cloud Solutions creates and maintains free, open-source tools to help startups thrive in the AWS Cloud and DevOps space. Our mission is to make advanced technology accessible to businesses of all sizes.

With years of experience and a commitment to innovation, we design solutions that simplify workflows, encourage collaboration, and drive growth - removing cost barriers along the way. Every contribution brings us closer to a future where technology empowers all.

Your support makes everything we do possible.

Thank you for being part of our journey to empower innovation and build a stronger Open Source future!

## Contributing

The project is under active development, and we welcome all contributors! 🎉 

Before you start, please review our [Contributor Guidelines](CONTRIBUTING.md) to understand the expectations and processes.

## Blog

Link to our [blog](https://thecloudsolutions.com/blog), where you can explore in-depth articles. Gain valuable insights and expert analysis on AWS cloud solution strategies and trends.

## License

The project is 100% Open Source and licensed under the [APACHE2](LICENSE).

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## Copyrights

Copyright © 2020-2026 [Cloud Solutions](https://thecloudsolutions.com)

[banner]: https://github.com/thecloudsolutions/.github/blob/main/profile/banner.png