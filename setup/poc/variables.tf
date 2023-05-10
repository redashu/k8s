variable "x" {
  type = string
}

variable "y" {
  type = string 
  validation {
    condition     = length(var.y) > 4 && substr(var.y, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
  validation {
    condition = can(regex("^ami-",var.y))
    error_message = "image is not starting with ami keyword"
  }
  
}

variable "number_of_instances" {
    type = number 
    default = 4
    validation {
        condition = var.number_of_instances > 1 && var.number_of_instances < 5
        error_message   = "Minimum 2 instances and max can't be more than 5 "
    }  
}

variable "z" {
  type = bool
}