variable "root_management_group_id" {
  description = "Root management group ID. Usually same as tenant ID."
  type        = string
  default     = ""
}

variable "principal_object_id" {
  description = "Object ID (user/group/service principal) to receive custom role assignment."
  type        = string
}
