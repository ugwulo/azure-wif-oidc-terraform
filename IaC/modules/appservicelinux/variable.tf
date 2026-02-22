variable "config1" {
  type = object({
    app-service-plan = list(object({
      name                = string
      location            = string
      resource_group_name = string
      sku_name            = string 
      os_type             = string 
    }))
})
}

variable "config2" {
  type = object({
    app-service = list(object({
      name                = string
      location            = string
      resource_group_name = string
      service_plan_id = string
      site_config = object({
        ftps_state       = string 
        always_on        = bool 
        application_stack= object({
          docker_image_name = string 
          docker_registry_url = string
        })
      })
      # app_settings = object({
      #   SOME_KEY = string
      # })
      # connection_string = object({
      #   name  = string
      #   type  = string
      #   value = string
      # })
    }))
  })
  
}
