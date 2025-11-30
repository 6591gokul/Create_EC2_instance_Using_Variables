

variable "instance_type" {
  default = "t3.micro"
  type    = string
}
variable "ami_id" {
  default = "ami-02d26659fd82cf299"
  type    = string
}
variable "volume_size" {
  default = 15
  type    = number
}
variable "volume_type" {
  default = "gp3"
  type    = string
}