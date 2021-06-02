variable "costcenter" {
    default = "admin"
    description = "Cost center of these artifacts"
    validation {
      condition = contains(["platform","reference-source-repo","security","admin","devsecops","shared-services"], var.costcenter)
      error_message = "The cost center is not a valid costcenter."
    }
}

variable "thisproject" {
    description = "The project to hold state for"
    type = string
}

variable "src" {
    description = "The artifact that we are using to source this deployment"
    type = string
}

variable "environment" {
    description = "Environment of this deployment"
    type = string
}
