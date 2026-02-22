variable "config" {
  type = object({
    rg = list(object({
      name     = string
      rg_prefix = optional(string)
      location = string
      tags     = map(string)
    }))
  })
}