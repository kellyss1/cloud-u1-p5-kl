#Configuracion del proveedor de AWS
provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos
}

#Creamos el security group para la instancia
resource "aws_security_group" "mi_security_group" {
    name = "mi-security-group-terraform" # nombre del security group
    description = "Security group para mi instancia de Terraform" #descripccion del sg
    vpc_id = "vpc-0856e303a983cbc0f" #Id del VPC donde se creará el sg

    #regla de entrada para SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #regla de salida para HTTP
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
}

#Declaraciond de los recursos de AWS
resource "aws_instance" "mi_instancia" {
    ami = "ami-0c230065b91270bc6" #ID de la AMI que se utilizara para crear la instancia
    instance_type = "t2.micro" #tipo de instancia
    key_name = "mi-primera-llaves-kl" #nombre del par de llaves que se utilizara para acceder a la instancia
    tags = {
        Name = "mi-instancia-terraform2" #nombre de la instancia
    }
    vpc_security_group_ids = [aws_security_group.mi_security_group.id]
}