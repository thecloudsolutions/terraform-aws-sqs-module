variable "sqs_map" {
  type = map(object({
    queues = optional(map(object({
      region                            = optional(string)
      content_based_deduplication       = optional(bool)
      deduplication_scope               = optional(string)
      delay_seconds                     = optional(number)
      fifo_queue                        = optional(bool)
      fifo_throughput_limit             = optional(string)
      kms_data_key_reuse_period_seconds = optional(number)
      kms_master_key_id                 = optional(string)
      kms_key_custom_name               = optional(string)
      replica_key_custom_name           = optional(string)
      max_message_size                  = optional(number)
      message_retention_seconds         = optional(number)
      name                              = optional(string)
      name_prefix                       = optional(string)
      policy                            = optional(string)
      # (Optional) Inline policy. Do not combine with queue_policies targeting this queue.
      receive_wait_time_seconds = optional(number)
      redrive_allow_policy      = optional(string)
      # (Optional) Inline redrive allow policy. Do not combine with redrive_allow_policies targeting this queue.
      redrive_policy = optional(string)
      # (Optional) Inline redrive policy. Do not combine with redrive_policies targeting this queue.
      sqs_managed_sse_enabled    = optional(bool)
      visibility_timeout_seconds = optional(number)

      timeouts = optional(object({
        create = optional(string)
        update = optional(string)
        delete = optional(string)
      }))

      tags = optional(map(string))
    })), {})

    queue_policies = optional(map(object({
      region = optional(string)
      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.
      policy             = optional(string)
      iam_custom_name    = optional(string)
      policy_custom_name = optional(string)
      queue_url          = optional(string)
      # (Optional) Queue URL. Takes precedence over queue_custom_name.
      queue_custom_name = optional(string)
      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.
    })), {})

    redrive_allow_policies = optional(map(object({
      region = optional(string)
      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.
      queue_url = optional(string)
      # (Optional) Queue URL. Takes precedence over queue_custom_name.
      queue_custom_name = optional(string)
      # (Optional) Key in queues within this sqs_map entry. Required when queue_url is omitted.
      redrive_allow_policy = optional(string)
      # (Optional) JSON policy. Takes precedence over the structured policy fields.
      redrive_permission = optional(string)
      # (Optional) Required when redrive_allow_policy is omitted. Valid values are allowAll, denyAll and byQueue.
      source_queue_arns = optional(set(string))
      # (Optional) Source queue ARNs for byQueue. Takes precedence over source_queue_custom_names.
      source_queue_custom_names = optional(set(string), [])
      # (Optional) Source queue keys in queues within this sqs_map entry for byQueue when source_queue_arns is omitted.
    })), {})

    redrive_policies = optional(map(object({
      region = optional(string)
      # (Optional) Defaults to the selected managed queue region when queue_url is omitted.
      queue_url = optional(string)
      # (Optional) Source queue URL. Takes precedence over queue_custom_name.
      queue_custom_name = optional(string)
      # (Optional) Source queue key in queues within this sqs_map entry. Required when queue_url is omitted.
      redrive_policy = optional(string)
      # (Optional) JSON policy. Takes precedence over the structured policy fields.
      dead_letter_target_arn = optional(string)
      # (Optional) Destination queue ARN. Takes precedence over dead_letter_target_custom_name.
      dead_letter_target_custom_name = optional(string)
      # (Optional) Destination queue key in queues within this sqs_map entry. Required when redrive_policy and dead_letter_target_arn are omitted.
      max_receive_count = optional(number)
      # (Optional) Required when redrive_policy is omitted. Number of receives before moving a message to the destination queue.
    })), {})
  }))

  description = "Keyed collection of sqs definitions"
}

variable "kms_map" {
  type = map(object({
    key = optional(object({
      region                             = optional(string)
      description                        = optional(string)
      key_usage                          = optional(string)
      custom_key_store_id                = optional(string)
      custom_key_store_custom_name       = optional(string)
      customer_master_key_spec           = optional(string)
      policy                             = optional(string)
      iam_custom_name                    = optional(string)
      policy_custom_name                 = optional(string)
      bypass_policy_lockout_safety_check = optional(bool)
      deletion_window_in_days            = optional(number)
      is_enabled                         = optional(bool)
      enable_key_rotation                = optional(bool)
      rotation_period_in_days            = optional(number)
      multi_region                       = optional(bool)
      xks_key_id                         = optional(string)
      tags                               = optional(map(string))
      timeouts = optional(object({
        create = optional(string)
      }))
    }))

    external_key = optional(object({
      region                             = optional(string)
      description                        = optional(string)
      key_spec                           = optional(string)
      key_usage                          = optional(string)
      policy                             = optional(string)
      iam_custom_name                    = optional(string)
      policy_custom_name                 = optional(string)
      bypass_policy_lockout_safety_check = optional(bool)
      deletion_window_in_days            = optional(number)
      enabled                            = optional(bool)
      key_material_base64                = optional(string)
      multi_region                       = optional(bool)
      valid_to                           = optional(string)
      tags                               = optional(map(string))
    }))

    existing_key = optional(object({
      region       = optional(string)
      key_id       = string
      grant_tokens = optional(list(string))
    }))

    aliases = optional(map(object({
      region                  = optional(string)
      name                    = optional(string)
      name_prefix             = optional(string)
      target_key_id           = optional(string)
      replica_key_custom_name = optional(string)
    })), {})

    grants = optional(map(object({
      region                                   = optional(string)
      key_id                                   = optional(string)
      replica_key_custom_name                  = optional(string)
      name                                     = optional(string)
      grantee_principal                        = optional(string)
      grantee_iam_custom_name                  = optional(string)
      grantee_role_custom_name                 = optional(string)
      grantee_user_custom_name                 = optional(string)
      grantee_service_linked_role_custom_name  = optional(string)
      operations                               = set(string)
      retiring_principal                       = optional(string)
      retiring_iam_custom_name                 = optional(string)
      retiring_role_custom_name                = optional(string)
      retiring_user_custom_name                = optional(string)
      retiring_service_linked_role_custom_name = optional(string)
      retire_on_delete                         = optional(bool)
      grant_creation_tokens                    = optional(set(string))
      constraints = optional(set(object({
        encryption_context_equals = optional(map(string))
        encryption_context_subset = optional(map(string))
      })))
    })), {})

    replica_keys = optional(map(object({
      region                             = optional(string)
      primary_key_arn                    = optional(string)
      description                        = optional(string)
      policy                             = optional(string)
      iam_custom_name                    = optional(string)
      policy_custom_name                 = optional(string)
      bypass_policy_lockout_safety_check = optional(bool)
      deletion_window_in_days            = optional(number)
      enabled                            = optional(bool)
      tags                               = optional(map(string))
    })), {})

    replica_external_keys = optional(map(object({
      region                             = optional(string)
      primary_key_arn                    = optional(string)
      description                        = optional(string)
      policy                             = optional(string)
      iam_custom_name                    = optional(string)
      policy_custom_name                 = optional(string)
      bypass_policy_lockout_safety_check = optional(bool)
      deletion_window_in_days            = optional(number)
      enabled                            = optional(bool)
      key_material_base64                = optional(string)
      valid_to                           = optional(string)
      tags                               = optional(map(string))
    })), {})

    key_policy = optional(object({
      region                             = optional(string)
      key_id                             = optional(string)
      policy                             = optional(string)
      iam_custom_name                    = optional(string)
      policy_custom_name                 = optional(string)
      bypass_policy_lockout_safety_check = optional(bool)
    }))

    custom_key_stores = optional(map(object({
      region                   = optional(string)
      custom_key_store_name    = string
      custom_key_store_type    = optional(string)
      cloud_hsm_cluster_id     = optional(string)
      key_store_password       = optional(string)
      trust_anchor_certificate = optional(string)
      xks_proxy_authentication_credential = optional(object({
        access_key_id         = string
        raw_secret_access_key = string
      }))
      xks_proxy_connectivity              = optional(string)
      xks_proxy_uri_endpoint              = optional(string)
      xks_proxy_uri_path                  = optional(string)
      xks_proxy_vpc_endpoint_service_name = optional(string)
      timeouts = optional(object({
        create = optional(string)
        update = optional(string)
        delete = optional(string)
      }))
    })), {})

    public_key = optional(object({
      region                  = optional(string)
      key_id                  = optional(string)
      replica_key_custom_name = optional(string)
      grant_tokens            = optional(list(string))
    }))
  }))

  description = "Keyed collection of kms definitions"
  default     = {}
}

variable "iam_map" {
  type = map(object({
    account_alias = optional(object({
      account_alias = string
    }))

    account_password_policy = optional(object({
      allow_users_to_change_password = optional(bool)
      hard_expiry                    = optional(bool)
      max_password_age               = optional(number)
      minimum_password_length        = optional(number)
      password_reuse_prevention      = optional(number)
      require_lowercase_characters   = optional(bool)
      require_numbers                = optional(bool)
      require_symbols                = optional(bool)
      require_uppercase_characters   = optional(bool)
    }))

    role = optional(object({
      assume_role_policy                      = optional(string)
      assume_role_policy_document_custom_name = optional(string)
      description                             = optional(string)
      force_detach_policies                   = optional(bool)
      inline_policy = optional(set(object({
        name   = string
        policy = string
      })), [])

      managed_policy_arns              = optional(set(string))
      max_session_duration             = optional(number)
      name                             = optional(string)
      name_prefix                      = optional(string)
      path                             = optional(string)
      permissions_boundary             = optional(string)
      permissions_boundary_custom_name = optional(string)

      tags = optional(map(string))
    }))

    policy_documents = optional(map(object({
      override_policy_documents = optional(list(string))
      policy_id                 = optional(string)
      source_policy_documents   = optional(list(string))
      policy_version            = optional(string)

      statement = optional(list(object({
        actions       = optional(set(string))
        effect        = optional(string)
        not_actions   = optional(set(string))
        not_resources = optional(set(string))
        resources     = optional(set(string))
        sid           = optional(string)

        condition = optional(set(object({
          test     = string
          variable = string
          values   = list(any)
        })), [])

        principals = optional(set(object({
          identifiers                = set(string)
          saml_provider_custom_names = optional(set(string), [])
          type                       = string
        })), [])

        not_principals = optional(set(object({
          identifiers                = set(string)
          saml_provider_custom_names = optional(set(string), [])
          type                       = string
        })), [])
      })), [])
    })), {})

    role_policies = optional(map(object({
      name                        = optional(string)
      name_prefix                 = optional(string)
      policy                      = optional(string)
      policy_document_custom_name = optional(string)
      role                        = optional(string)
    })), {})

    role_policy_attachments = optional(list(object({
      custom_name        = optional(string)
      policy_arn         = optional(string)
      policy_custom_name = optional(string)
      role               = optional(string)
    })), [])

    role_policies_exclusive = optional(object({
      role_name           = optional(string)
      policy_names        = set(string)
      policy_custom_names = optional(set(string), [])
    }))

    instance_profile = optional(object({
      name        = optional(string)
      name_prefix = optional(string)
      path        = optional(string)
      role        = optional(string)
      tags        = optional(map(string))
    }))

    policy_attachments_exclusive = optional(object({
      policy_arns         = set(string)
      policy_custom_names = optional(set(string), [])
      role_name           = optional(string)
    }))

    policies = optional(map(object({
      policy                            = optional(string)
      policy_custom_name                = optional(string)
      delay_after_policy_creation_in_ms = optional(number)
      description                       = optional(string)
      name                              = optional(string)
      name_prefix                       = optional(string)
      path                              = optional(string)
      tags                              = optional(map(string))
    })), {})

    users = optional(map(object({
      name                             = string
      path                             = optional(string)
      permissions_boundary             = optional(string)
      permissions_boundary_custom_name = optional(string)
      force_destroy                    = optional(bool)
      tags                             = optional(map(string))
    })), {})

    user_login_profiles = optional(map(object({
      user                    = optional(string)
      user_custom_name        = optional(string)
      pgp_key                 = optional(string)
      password_length         = optional(number)
      password_reset_required = optional(bool)
    })), {})

    access_keys = optional(map(object({
      user             = optional(string)
      user_custom_name = optional(string)
      pgp_key          = optional(string)
      status           = optional(string)
    })), {})

    user_ssh_keys = optional(map(object({
      username         = optional(string)
      user_custom_name = optional(string)
      encoding         = string
      public_key       = string
      status           = optional(string)
    })), {})

    groups = optional(map(object({
      name = string
      path = optional(string)
    })), {})

    user_policies = optional(map(object({
      name                        = optional(string)
      name_prefix                 = optional(string)
      policy                      = optional(string)
      policy_document_custom_name = optional(string)
      user                        = optional(string)
      user_custom_name            = optional(string)
    })), {})

    user_policy_attachments = optional(map(object({
      user               = optional(string)
      user_custom_name   = optional(string)
      policy_arn         = optional(string)
      policy_custom_name = optional(string)
    })), {})

    user_policies_exclusive = optional(map(object({
      user_name           = optional(string)
      user_custom_name    = optional(string)
      policy_names        = set(string)
      policy_custom_names = optional(set(string), [])
    })), {})

    user_policy_attachments_exclusive = optional(map(object({
      user_name           = optional(string)
      user_custom_name    = optional(string)
      policy_arns         = set(string)
      policy_custom_names = optional(set(string), [])
    })), {})

    group_policies = optional(map(object({
      name                        = optional(string)
      name_prefix                 = optional(string)
      policy                      = optional(string)
      policy_document_custom_name = optional(string)
      group                       = optional(string)
      group_custom_name           = optional(string)
    })), {})

    group_policy_attachments = optional(map(object({
      group              = optional(string)
      group_custom_name  = optional(string)
      policy_arn         = optional(string)
      policy_custom_name = optional(string)
    })), {})

    group_policies_exclusive = optional(map(object({
      group_name          = optional(string)
      group_custom_name   = optional(string)
      policy_names        = set(string)
      policy_custom_names = optional(set(string), [])
    })), {})

    group_policy_attachments_exclusive = optional(map(object({
      group_name          = optional(string)
      group_custom_name   = optional(string)
      policy_arns         = set(string)
      policy_custom_names = optional(set(string), [])
    })), {})

    group_memberships = optional(map(object({
      name              = string
      users             = set(string)
      user_custom_names = optional(set(string), [])
      group             = optional(string)
      group_custom_name = optional(string)
    })), {})

    user_group_memberships = optional(map(object({
      user   = optional(string)
      groups = optional(set(string), [])
    })), {})

    openid_connect_providers = optional(map(object({
      url             = string
      client_id_list  = set(string)
      thumbprint_list = optional(list(string))
      tags            = optional(map(string))
    })), {})

    saml_providers = optional(map(object({
      name                   = string
      saml_metadata_document = string
      tags                   = optional(map(string))
    })), {})

    service_linked_roles = optional(map(object({
      aws_service_name = string
      custom_suffix    = optional(string)
      description      = optional(string)
      tags             = optional(map(string))
    })), {})
  }))

  description = "Keyed collection of iam definitions"
  default     = {}
}
