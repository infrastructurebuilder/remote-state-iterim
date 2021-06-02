variable "thisbucket" {
    description = "Name of remote state bucket to create"
    type = string
}

variable "isprod" {
    description = "Set to yes if prod"
    default = "yes"
    type = string
}

variable "owner" {
    description = "Owner of the resources"
    type = string
}

variable "eoldate" {
    description = "Destroy date"
    default = "2050-12-01"
    type = string
}

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
