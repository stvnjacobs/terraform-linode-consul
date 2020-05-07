variable "cluster_name" {
  description = "The name of the Consul cluster (e.g. consul-stage). This variable is used to namespace all resources created by this module."
  type        = string
  default     = "tf-linode-consul"
}

variable "image_id" {
  description = "The ID of the Linode Image to run in this cluster. Should be an AMI that had Consul installed and configured by the install-consul module."
  type        = string
  default     = "private/8777037"
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
