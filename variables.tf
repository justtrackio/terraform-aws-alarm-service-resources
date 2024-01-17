variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "cpu_average" {
  type = object({
    datapoints_to_alarm = optional(number)
    evaluation_periods  = optional(number)
    period              = optional(number)
    threshold           = optional(number)
  })
  description = "Average CPUUtilization alarm specs"
  default     = {}
}

variable "cpu_maximum" {
  type = object({
    datapoints_to_alarm = optional(number)
    evaluation_periods  = optional(number)
    period              = optional(number)
    threshold           = optional(number)
  })
  description = "Maximum CPUUtilization alarm specs"
  default     = {}
}

variable "label_orders" {
  type = object({
    cloudwatch = optional(list(string)),
    ecs        = optional(list(string))
  })
  default     = {}
  description = "Overrides the `labels_order` for the different labels to modify ID elements appear in the `id`"
}

variable "memory_average" {
  type = object({
    datapoints_to_alarm = optional(number)
    evaluation_periods  = optional(number)
    period              = optional(number)
    threshold           = optional(number)
  })
  description = "Average MemoryUtilization alarm specs"
  default     = {}
}

variable "memory_maximum" {
  type = object({
    datapoints_to_alarm = optional(number)
    evaluation_periods  = optional(number)
    period              = optional(number)
    threshold           = optional(number)
  })
  description = "Maximum MemoryUtilization alarm specs"
  default     = {}
}

variable "treat_missing_data" {
  type        = string
  default     = null
  description = "The way missing data points will affect the alarm state. Either of the following is supported: breaching, notBreaching"

  validation {
    condition     = contains(["breaching", "notBreaching"], var.treat_missing_data)
    error_message = "Valid values: `breaching`, `notBreaching`."
  }
}
