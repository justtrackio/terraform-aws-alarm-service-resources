locals {
  alarm_topic_arn = var.alarm_topic_arn != null ? var.alarm_topic_arn : "arn:aws:sns:${module.this.aws_region}:${module.this.aws_account_id}:${module.this.environment}-alarms"
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = module.ecs_label.id
  }
}

module "cloudwatch_label" {
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
  version = "5.3.1"

  alarm_name = "${module.cloudwatch_label.id}-cpu-average"
  alarm_description = jsonencode(merge(module.this.tags, {
    Severity = "warning"
  }))
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

  alarm_actions = [local.alarm_topic_arn]
  ok_actions    = [local.alarm_topic_arn]
}

module "cpu_maximum" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "5.3.1"

  alarm_name = "${module.cloudwatch_label.id}-cpu-maximum"
  alarm_description = jsonencode(merge(module.this.tags, {
    Severity = "warning"
  }))
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

  alarm_actions = [local.alarm_topic_arn]
  ok_actions    = [local.alarm_topic_arn]
}

module "memory_average" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "5.3.1"

  alarm_name = "${module.cloudwatch_label.id}-memory-average"
  alarm_description = jsonencode(merge(module.this.tags, {
    Severity = "warning"
  }))
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

  alarm_actions = [local.alarm_topic_arn]
  ok_actions    = [local.alarm_topic_arn]
}

module "memory_maximum" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "5.3.1"

  alarm_name = "${module.cloudwatch_label.id}-memory-maximum"
  alarm_description = jsonencode(merge(module.this.tags, {
    Severity = "warning"
  }))
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

  alarm_actions = [local.alarm_topic_arn]
  ok_actions    = [local.alarm_topic_arn]
}
