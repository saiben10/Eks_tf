variable "cidr_range" {
  type = string
}

variable "sub_range" {
  type = string
}

variable "abc" {
    type = map(object({
        name = string
        no = number 
    }))
    default = {
      "dem01" = {
        name = sample
        no = 1
      }
    }
  
}

variable "str" {
    type = map(string)
    default = {
      "name" = "value"
    }
  
}

resource "aws_subnet" "name" {
  for_each = var.for_loop
  vpc_id = each.value.name
}
variable "for_loop" {
    type = map(object({
        name = string,
        no = number 
    }))
    default = {
        one = {
            name = "hello"
            no = 1
        }

        two = {
            name = "two"
            no = 2
        }
    }  
}
