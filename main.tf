module "sqs" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-sqs-component.git?ref=main"

  sqs_map = { for key, sqs in var.sqs_map :
    key => merge(sqs,
      {
        queues = { for queue_key, queue in sqs.queues :
          queue_key => merge(queue,
            { kms_master_key_id = try(queue.kms_master_key_id, null) != null ? queue.kms_master_key_id : try(queue.replica_key_custom_name, null) != null ? try(module.kms.kms_replica_external_key_arns[queue.kms_key_custom_name][queue.replica_key_custom_name], module.kms.kms_replica_key_arns[queue.kms_key_custom_name][queue.replica_key_custom_name]) : try(queue.kms_key_custom_name, null) != null ? module.kms.kms_key_arns[queue.kms_key_custom_name] : null }
          )
        }

        queue_policies = { for policy_key, policy in sqs.queue_policies :
          policy_key => merge(policy,
            { policy = try(policy.policy, null) != null ? policy.policy : module.iam.iam_policy_document_jsons[policy.iam_custom_name][policy.policy_custom_name] }
          )
        }
      }
    )
  }

  depends_on = [module.kms, module.iam]
}

module "kms" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-kms-component.git?ref=main"

  kms_map = { for key, kms in var.kms_map :
    key => merge(kms,
      {
        key = try(kms.key, null) != null ? merge(kms.key,
          { policy = try(kms.key.policy, null) != null ? kms.key.policy : try(kms.key.policy_custom_name, null) != null ? module.iam.iam_policy_document_jsons[kms.key.iam_custom_name][kms.key.policy_custom_name] : null }
        ) : null

        external_key = try(kms.external_key, null) != null ? merge(kms.external_key,
          { policy = try(kms.external_key.policy, null) != null ? kms.external_key.policy : try(kms.external_key.policy_custom_name, null) != null ? module.iam.iam_policy_document_jsons[kms.external_key.iam_custom_name][kms.external_key.policy_custom_name] : null }
        ) : null

        grants = { for grant_key, grant in kms.grants :
          grant_key => merge(grant,
            {
              grantee_principal  = try(grant.grantee_principal, null) != null ? grant.grantee_principal : try(grant.grantee_role_custom_name, null) != null ? module.iam.iam_role_arns[grant.grantee_role_custom_name] : try(grant.grantee_user_custom_name, null) != null ? module.iam.iam_user_arns[grant.grantee_iam_custom_name][grant.grantee_user_custom_name] : try(grant.grantee_service_linked_role_custom_name, null) != null ? module.iam.iam_service_linked_role_arns[grant.grantee_iam_custom_name][grant.grantee_service_linked_role_custom_name] : null
              retiring_principal = try(grant.retiring_principal, null) != null ? grant.retiring_principal : try(grant.retiring_role_custom_name, null) != null ? module.iam.iam_role_arns[grant.retiring_role_custom_name] : try(grant.retiring_user_custom_name, null) != null ? module.iam.iam_user_arns[grant.retiring_iam_custom_name][grant.retiring_user_custom_name] : try(grant.retiring_service_linked_role_custom_name, null) != null ? module.iam.iam_service_linked_role_arns[grant.retiring_iam_custom_name][grant.retiring_service_linked_role_custom_name] : null
            }
          )
        }

        replica_keys = { for replica_key, replica in kms.replica_keys :
          replica_key => merge(replica,
            { policy = try(replica.policy, null) != null ? replica.policy : try(replica.policy_custom_name, null) != null ? module.iam.iam_policy_document_jsons[replica.iam_custom_name][replica.policy_custom_name] : null }
          )
        }

        replica_external_keys = { for replica_key, replica in kms.replica_external_keys :
          replica_key => merge(replica,
            { policy = try(replica.policy, null) != null ? replica.policy : try(replica.policy_custom_name, null) != null ? module.iam.iam_policy_document_jsons[replica.iam_custom_name][replica.policy_custom_name] : null }
          )
        }

        key_policy = try(kms.key_policy, null) != null ? merge(kms.key_policy,
          { policy = try(kms.key_policy.policy, null) != null ? kms.key_policy.policy : try(kms.key_policy.policy_custom_name, null) != null ? module.iam.iam_policy_document_jsons[kms.key_policy.iam_custom_name][kms.key_policy.policy_custom_name] : null }
        ) : null
      }
    )
  }
}

module "iam" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-iam-component.git?ref=main"

  iam_map = var.iam_map
}
