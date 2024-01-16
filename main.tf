locals {
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = module.ecs_label.id
  }
}

module "alarm_label" {
  source  = "justtrackio/label/null"
  version = "0.26.0"

  context     = module.this.context
  label_order = var.label_orders.cloudwatch
}

module "ecs_label" {
  source  = "justtrackio/label/null"
  version = "0.26.0"

  context     = module.this.context
  label_order = var.label_orders.ecs
}

module "cpu_average" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "5.1.0"

  alarm_name          = "${module.alarm_label.id}-cpu-average"
  treat_missing_data  = var.treat_missing_data
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.cpu_average.threshold
  evaluation_periods  = var.cpu_average.evaluation_periods
  datapoints_to_alarm = var.cpu_average.datapoints_to_alarm

  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"
  period      = var.cpu_average.period
  statistic   = "Average"
  dimensions  = local.dimensions
  tags        = module.this.tags
}

module "cpu_maximum" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "5.1.0"

  alarm_name          = "${module.alarm_label.id}-cpu-maximum"
  treat_missing_data  = var.treat_missing_data
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.cpu_maximum.threshold
  evaluation_periods  = var.cpu_maximum.evaluation_periods
  datapoints_to_alarm = var.cpu_maximum.datapoints_to_alarm

  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"
  period      = var.cpu_maximum.period
  statistic   = "Maximum"
  dimensions  = local.dimensions
  tags        = module.this.tags
}

module "memory_average" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "5.1.0"

  alarm_name          = "${module.alarm_label.id}-memory-average"
  treat_missing_data  = var.treat_missing_data
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.memory_average.threshold
  evaluation_periods  = var.memory_average.evaluation_periods
  datapoints_to_alarm = var.memory_average.datapoints_to_alarm

  metric_name = "MemoryUtilization"
  namespace   = "AWS/ECS"
  period      = var.memory_average.period
  statistic   = "Average"
  dimensions  = local.dimensions
  tags        = module.this.tags
}

module "memory_maximum" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "5.1.0"

  alarm_name          = "${module.alarm_label.id}-memory-maximum"
  treat_missing_data  = var.treat_missing_data
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.memory_maximum.threshold
  evaluation_periods  = var.memory_maximum.evaluation_periods
  datapoints_to_alarm = var.memory_maximum.datapoints_to_alarm

  metric_name = "MemoryUtilization"
  namespace   = "AWS/ECS"
  period      = var.memory_maximum.period
  statistic   = "Maximum"
  dimensions  = local.dimensions
  tags        = module.this.tags
}
