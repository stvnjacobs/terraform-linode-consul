variable "cluster_name" {
  description = "The name of the Consul cluster (e.g. consul-stage). This variable is used to namespace all resources created by this module."
  type        = string
  default     = "tf-linode-consul"
}

variable "image_id" {
  description = "The ID of the Linode Image to run in this cluster. Should be an disk image that had Consul installed and configured by the install-consul module."
  type        = string
  default     = "private/8783532"
}

# TODO: multi-region support
variable "region" {
  description = "The region into which the Linode instances should be deployed."
  type        = string
  default     = "us-east"
}

variable "ssh_keys" {
  description = "A list of SSH Key Pairs that can be used to SSH to the Linode instances in this cluster. Set to an empty list to not associate any Key Pairs."
  type        = list(string)
  default     = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD5xiqSTTHfIV4wvOKZY3g/oUii3T3cUVkSEU5kv9tKUr1wbrGLNlM0QGkLY+p8ub2/63OugHIGPOduzsGx2+wZxgbochhWl0VUY9BW5IC+wYSnXu6iwfXmH2eeDxJFF8HRPqso3hDPVJasvmyeJezeMnWREnLE6A6bCv2SvpmDO24KEBbAlSXp8Jo5pTqZ5OYIKDCbfEq78nqNuzPy+XId+ht5QMrJdatEHM2aZjeSrLDKSwGXGSlxk6vAGR7oiGWiRu4rIyH48hXfRKmBQORUYtQHCsyv1/5nRnlELDcrZE7h7I1u/xG+xl8Z8WE+wm9QpUZHXpqLul1sYRi2LgrPcYZldLZvv3lCPMkpsg4hgMxWKip8vRXgFbParJ6LzRpLacyN75iLOh/0gG/j7MHNdn/b+mLXjxd/cG+11Il9li3htzaNeHbpubpo77x2inMHx2a0txyV2WN+qcifduYALMlyCgntcsAH+m0AsehRKE/feqGRBYUaaxI4AEB55gN486m/qWsQl6bdlq/bCIsJl2v7JshK6/P8oqqsdV5oasaap4xoRwNpmqAg5P/VXiUt2DlmNSnHybqdgwA8GJMXw6Yj6RM+bPjpA0EnhOb0PcLMm/w/JCUOHwz43rAOjsS7IpFLZpZrsOXJWrn1gpFjLrWjxs32SVZmEgy4EEWTgw==",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbQEdM7a2Ux0j5P7AZYj2xk+ERANp/tROPnPD2n66bW89kbzCFuw6x5x40MZzE4TMPkZPRsDbwgipd55GoXAbDW9E2uodeoycEkMLe/YeUlPS0n+zLcgcfn2oOwrzqq8buOX9/Ru+E0ouBBL/nnjJUFIgeeeL/WomdLnuWAnYQp3IQKN3mx0qLQqRLtWwV3hPmU5uAo+SzIaoYWJoHbZtWZRVUUIz7/pMYHaTxtJWJHjUZoXtMpEXAgWDO3nkeUW0PHvmmylyCGkzMWcES2IVlV9XssGDoJYOkh4Utxl5S/3LR7U8UBzIX/WL0SxDxxwAjuIJgZDr9Xhe+cBOBxPdeFGNFCAngHKlfZpsZFTuhAK25Tm2AhwKF2270c6yaWjNjWXW+3ZYLtO2KcTaW6ZzEYh25QJi9Yr3tAewqUXhm5I5JXzhLQjZ7122O6YayhJYBvt2DsX/07XfHt0e6kV4aFX+lVpNx6X5G2cgxITPUzjscy1Plz5wLSPNxSZiLBStOJPGaGsildJF/ezwfZEib+aRv3FTuBqEW59buhwxPKq0GoAH1NsKH7em243dRUB7yurF8wdJJmcChjVfOPW/fL1lMR0rrDKhK0mT4xa3D5Yd9eNsAG5Qr6qjJkiNc/Y1sMy4w+nGgtf7spCW3ZMuNuw079MCgMAUzFUMSGCGcBQ==",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCXv6CSI0r6s/4JmphfURv4I74kiBpoWmjiNYp+1EQu44BkcjeC3YYGI+YCXgqz8C2lNbhqtK4YcsL5eVGijW71t6lkHehOUk/n4mITRX2Auh1IvvpJPK7dpa/JNnSXjfg/v/M9ArgfuZUHKGOR4W+ieTfe1B1Uv9+lyPqjL12VoGwF59tLm5W3EphpJQo48Y4bRY+7daJ9h7lTj5nN8jztVUcmx/PPNtyqp7nesOck4lUtz7OgWDo+r7slSDGqgEswZdldXYNsDOp3lYKrD76HsFtO3va9MPGcYv+Fxpc66xme//zXbRNMj9Mmbg3abRPHi6MQPBP/FH26agtflB26lFibCYx3DZ2h94AWRIrmAOinABoFS8I0c6R9COrPkRHjo16cCuBLgYXqZezklEzj6GQwh1rOMx4puapc3Z0ItIp1w93sMqHqy0Gh+iw57X8g8RMoXei96uD2Aqf3bRgF+8JXfP1z2H3aYfsjtsWXmquhzIyFQXqO6xBUix+pL5ZPlfAWYyr8nsl0wAomI6RQvlRLZQEKW+UqV6szopJBwGQm8oAf0emV9+y4hEBQjxQG0GR+m5o8E91L0QX0dw39Fay6v1vOrDxo7AeVSzDS1nvosoeR5XmI7x1B/6PKFr4aebU1bJA5hFjyr88bGkPGWySKxTmIhPVrqzPWDH8ytQ==",
  ]
}

variable "num_servers" {
  description = "The number of Consul server nodes to deploy. We strongly recommend using 3 or 5."
  type        = number
  default     = 3
}

variable "num_clients" {
  description = "The number of Consul client nodes to deploy. You typically run the Consul client alongside your apps, so set this value to however many Instances make sense for your app code."
  type        = number
  default     = 6
}

variable "cluster_tag_name" {
  description = "Add a tag with this name to each instance. This can be used to automatically find other Consul nodes and form a cluster."
  type        = string
  default     = "consul-servers-auto-join"
}

variable "tags" {
  description = "List of extra tag blocks added to the Linode instances in the cluster."
  type        = list(string)
  default     = []
}
