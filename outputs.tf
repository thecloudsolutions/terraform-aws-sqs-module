output "sqs_queue_arns" {
  value       = module.sqs.sqs_queue_arns
  description = "ARNs of the SQS queues, keyed by SQS definition and queue."
}

output "sqs_queue_ids" {
  value       = module.sqs.sqs_queue_ids
  description = "URLs of the SQS queues, keyed by SQS definition and queue."
}

output "sqs_queue_urls" {
  value       = module.sqs.sqs_queue_urls
  description = "URLs of the SQS queues, keyed by SQS definition and queue."
}

output "sqs_queue_tags_all" {
  value       = module.sqs.sqs_queue_tags_all
  description = "Tags assigned to the queues, including provider default tags, keyed by SQS definition and queue."
}

output "sqs_queue_names" {
  value       = module.sqs.sqs_queue_names
  description = "Names of the SQS queues, keyed by SQS definition and queue."
}

output "kms_key_arns" {
  value       = module.kms.kms_key_arns
  description = "The Amazon Resource Name (ARN) of the key."
}

output "kms_key_ids" {
  value       = module.kms.kms_key_ids
  description = "The globally unique identifier for the key."
}

output "kms_key_tags_all" {
  value       = module.kms.kms_key_tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "kms_alias_arns" {
  value       = module.kms.kms_alias_arns
  description = "The Amazon Resource Name (ARN) of the key alias."
}

output "kms_alias_target_key_arns" {
  value       = module.kms.kms_alias_target_key_arns
  description = "The Amazon Resource Name (ARN) of the target key identifier."
}

output "kms_key_regions" {
  value       = module.kms.kms_key_regions
  description = "Regions where the keys are managed."
}

output "kms_key_policies" {
  value       = module.kms.kms_key_policies
  description = "Map of key policy JSON documents."
}

output "kms_key_specs" {
  value       = module.kms.kms_key_specs
  description = "Types of key material."
}

output "kms_key_usages" {
  value       = module.kms.kms_key_usages
  description = "Permitted cryptographic uses of the keys."
}

output "kms_key_states" {
  value       = module.kms.kms_key_states
  description = "States of imported and existing keys."
}

output "kms_key_expiration_models" {
  value       = module.kms.kms_key_expiration_models
  description = "Whether imported key material expires."
}

output "kms_key_valid_to" {
  value       = module.kms.kms_key_valid_to
  description = "Expiration times of imported key material."
}

output "kms_alias_names" {
  value       = module.kms.kms_alias_names
  description = "Names of the key aliases."
}

output "kms_alias_name_prefixes" {
  value       = module.kms.kms_alias_name_prefixes
  description = "Prefixes used to generate the alias names."
}

output "kms_alias_target_key_ids" {
  value       = module.kms.kms_alias_target_key_ids
  description = "Identifiers of the keys associated with the aliases."
}

output "kms_alias_regions" {
  value       = module.kms.kms_alias_regions
  description = "Regions where the aliases are managed."
}

output "kms_grant_ids" {
  value       = module.kms.kms_grant_ids
  description = "Maps of grant identifiers."
}

output "kms_grant_tokens" {
  value       = module.kms.kms_grant_tokens
  description = "Maps of grant tokens."
  sensitive   = true
}

output "kms_grant_regions" {
  value       = module.kms.kms_grant_regions
  description = "Maps of grant regions."
}

output "kms_grant_key_ids" {
  value       = module.kms.kms_grant_key_ids
  description = "Maps of key IDs or ARNs to which the grants apply."
}

output "kms_grant_names" {
  value       = module.kms.kms_grant_names
  description = "Maps of grant names."
}

output "kms_grant_grantee_principals" {
  value       = module.kms.kms_grant_grantee_principals
  description = "Maps of grantee principals."
}

output "kms_grant_operations" {
  value       = module.kms.kms_grant_operations
  description = "Maps of operations permitted by the grants."
}

output "kms_grant_retiring_principals" {
  value       = module.kms.kms_grant_retiring_principals
  description = "Maps of retiring principals."
}

output "kms_grant_constraints" {
  value       = module.kms.kms_grant_constraints
  description = "Maps of encryption context constraints for the grants."
}

output "kms_replica_key_arns" {
  value       = module.kms.kms_replica_key_arns
  description = "The Amazon Resource Name (ARN) of the key."
}

output "kms_replica_key_ids" {
  value       = module.kms.kms_replica_key_ids
  description = "The globally unique identifier for the key."
}

output "kms_replica_key_regions" {
  value       = module.kms.kms_replica_key_regions
  description = "Region where the resource is managed."
}

output "kms_replica_key_policies" {
  value       = module.kms.kms_replica_key_policies
  description = "The key policy JSON document."
}

output "kms_replica_key_rotation_enabled" {
  value       = module.kms.kms_replica_key_rotation_enabled
  description = "Whether rotation is enabled for the related multi-Region keys."
}

output "kms_replica_key_specs" {
  value       = module.kms.kms_replica_key_specs
  description = "Type of key material."
}

output "kms_replica_key_usages" {
  value       = module.kms.kms_replica_key_usages
  description = "Permitted cryptographic use of the key."
}

output "kms_replica_key_enabled" {
  value       = module.kms.kms_replica_key_enabled
  description = "Whether the key is enabled."
}

output "kms_replica_key_tags_all" {
  value       = module.kms.kms_replica_key_tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "kms_replica_external_key_arns" {
  value       = module.kms.kms_replica_external_key_arns
  description = "The Amazon Resource Name (ARN) of the key."
}

output "kms_replica_external_key_ids" {
  value       = module.kms.kms_replica_external_key_ids
  description = "The globally unique identifier for the key."
}

output "kms_replica_external_key_regions" {
  value       = module.kms.kms_replica_external_key_regions
  description = "Region where the resource is managed."
}

output "kms_replica_external_key_policies" {
  value       = module.kms.kms_replica_external_key_policies
  description = "The key policy JSON document."
}

output "kms_replica_external_key_usages" {
  value       = module.kms.kms_replica_external_key_usages
  description = "Permitted cryptographic use of the key."
}

output "kms_replica_external_key_states" {
  value       = module.kms.kms_replica_external_key_states
  description = "The current state of the key."
}

output "kms_replica_external_key_expiration_models" {
  value       = module.kms.kms_replica_external_key_expiration_models
  description = "Whether the imported key material expires."
}

output "kms_replica_external_key_valid_to" {
  value       = module.kms.kms_replica_external_key_valid_to
  description = "Expiration time of the imported key material."
}

output "kms_replica_external_key_enabled" {
  value       = module.kms.kms_replica_external_key_enabled
  description = "Whether the key is enabled."
}

output "kms_replica_external_key_tags_all" {
  value       = module.kms.kms_replica_external_key_tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "kms_custom_key_store_ids" {
  value       = module.kms.kms_custom_key_store_ids
  description = "Maps of custom key store identifiers."
}

output "kms_existing_key_ids" {
  value       = module.kms.kms_existing_key_ids
  description = "The unique identifier of the resource."
}

output "kms_existing_key_arns" {
  value       = module.kms.kms_existing_key_arns
  description = "The Amazon Resource Name (ARN) of the key."
}

output "kms_existing_key_regions" {
  value       = module.kms.kms_existing_key_regions
  description = "Region where the resource is managed."
}

output "kms_existing_key_aws_account_ids" {
  value       = module.kms.kms_existing_key_aws_account_ids
  description = "AWS account that owns the key."
}

output "kms_existing_key_cloud_hsm_cluster_ids" {
  value       = module.kms.kms_existing_key_cloud_hsm_cluster_ids
  description = "CloudHSM cluster containing the key material."
}

output "kms_existing_key_creation_dates" {
  value       = module.kms.kms_existing_key_creation_dates
  description = "Creation date of the key."
}

output "kms_existing_key_custom_key_store_ids" {
  value       = module.kms.kms_existing_key_custom_key_store_ids
  description = "ID of the custom key store containing the key."
}

output "kms_existing_key_customer_master_key_specs" {
  value       = module.kms.kms_existing_key_customer_master_key_specs
  description = "Type of key material."
}

output "kms_existing_key_deletion_dates" {
  value       = module.kms.kms_existing_key_deletion_dates
  description = "Scheduled deletion date of the key."
}

output "kms_existing_key_descriptions" {
  value       = module.kms.kms_existing_key_descriptions
  description = "Description of the key."
}

output "kms_existing_key_enabled" {
  value       = module.kms.kms_existing_key_enabled
  description = "Whether the key is enabled."
}

output "kms_existing_key_expiration_models" {
  value       = module.kms.kms_existing_key_expiration_models
  description = "Whether the imported key material expires."
}

output "kms_existing_key_managers" {
  value       = module.kms.kms_existing_key_managers
  description = "Manager of the key."
}

output "kms_existing_key_specs" {
  value       = module.kms.kms_existing_key_specs
  description = "Type of key material."
}

output "kms_existing_key_states" {
  value       = module.kms.kms_existing_key_states
  description = "The current state of the key."
}

output "kms_existing_key_usages" {
  value       = module.kms.kms_existing_key_usages
  description = "Permitted cryptographic use of the key."
}

output "kms_existing_key_multi_region" {
  value       = module.kms.kms_existing_key_multi_region
  description = "Whether the key is a multi-Region key."
}

output "kms_existing_key_multi_region_configurations" {
  value       = module.kms.kms_existing_key_multi_region_configurations
  description = "Primary and replica configuration of the multi-Region key."
}

output "kms_existing_key_origins" {
  value       = module.kms.kms_existing_key_origins
  description = "Origin of the key material."
}

output "kms_existing_key_pending_deletion_window_in_days" {
  value       = module.kms.kms_existing_key_pending_deletion_window_in_days
  description = "Waiting period before deleting a multi-Region primary key."
}

output "kms_existing_key_valid_to" {
  value       = module.kms.kms_existing_key_valid_to
  description = "Expiration time of the imported key material."
}

output "kms_existing_key_xks_key_configurations" {
  value       = module.kms.kms_existing_key_xks_key_configurations
  description = "Configuration of the external key store key."
}

output "kms_public_keys" {
  value       = module.kms.kms_public_keys
  description = "Base64-encoded DER public keys."
}

output "kms_public_key_pems" {
  value       = module.kms.kms_public_key_pems
  description = "PEM-encoded public keys."
}

output "kms_public_key_arns" {
  value       = module.kms.kms_public_key_arns
  description = "ARNs of keys whose public keys were retrieved."
}

output "kms_public_key_encryption_algorithms" {
  value       = module.kms.kms_public_key_encryption_algorithms
  description = "Encryption algorithms supported by the keys."
}

output "kms_public_key_signing_algorithms" {
  value       = module.kms.kms_public_key_signing_algorithms
  description = "Signing algorithms supported by the keys."
}

output "iam_policy_document_jsons" {
  value       = module.iam.iam_policy_document_jsons
  description = "Standard JSON policy document rendered based on the arguments above."
}
