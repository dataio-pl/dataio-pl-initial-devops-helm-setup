variable "enabled" {
  description = "Set it to true to create the Helm Release in the cluster"
  type        = bool
  default     = false
}

variable "name" {
  description = "Release name"
  type        = string
  default     = ""
}

variable "description" {
  description = "Set release description attribute"
  type        = string
  default     = ""
}

variable "create_namespace" {
  description = "Create the namespace if it does not yet exist"
  type        = bool
  default     = false
}

variable "namespace" {
  description = "The namespace to install the release into. Defaults to default"
  type        = string
  default     = "default"
}

variable "repository" {
  description = "Repository URL where to locate the requested chart"
  type        = string
  default     = ""
}

variable "chart" {
  description = "Chart name to be installed"
  type        = string
  default     = ""
}

variable "chart_version" {
  description = "Specify the exact chart version to install"
  type        = string
  default     = ""
}

variable "chart_values" {
  description = "List of values in raw yaml to pass to helm"
  type        = list(any)
  default     = []
}

variable "set" {
  description = "Value block with custom values to be merged with the values yaml"
  type        = map(any)
  default     = {}
}

variable "set_sensitive" {
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff"
  type        = map(any)
  default     = {}
}

variable "atomic" {
  description = "If set, installation process purges chart on fail"
  type        = bool
  default     = false
}

variable "wait" {
  description = "Will wait until all resources are in a ready state before marking the release as successful"
  type        = bool
  default     = false
}
