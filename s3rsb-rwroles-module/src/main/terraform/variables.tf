variable "costcenter" {
    default = "admin"
    description = "Cost center of these artifacts"
    validation {
      condition = contains(["platform","RSR","security","admin","devsecops","shared","operations"], var.costcenter)
      error_message = "The cost center is not a valid costcenter."
    }
}


variable "eoldate" {
    description = "Destroy date"
    default = "2050-12-01"
    type = string
}

variable "owner" {
    description = "Owner of the resources"
    type = string
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

variable "s3_bucket_name" {
    description = "Bucket name to apply roles to"
}
