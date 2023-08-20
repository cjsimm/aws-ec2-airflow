variable "aws_region" {
    description = "AWS region"
    type = string
    default = "eu-north-1"
}

#Security & permissions 
variable "key_name" {
    description= "EC2 key name"
    type= string
    default= "airflow-key"
}

variable "airflow_access_permissions" {
    description = "list of managed policy arn (amazon resource name)s that the airflow instance is allowed to access reference:https://docs.aws.amazon.com/iam/index.html"
    type = list(string)
    default = [""]
}

#EC2 instance variables 
variable "instance_type" {
    description = "type of instance"
    type = string  
    default = "t3.micro"
}

variable "launch_script" {
    description = "bash script to execute when the instance is first created via the user_data argument"
    type = string
    default = "launch_script.sh"
}

#Values that can be accessed inside the launch script via the key
variable "launch_script_variables" {
    description= "any variables that need to be passed to the user_data launch script "
    type = map(string)
    default = {
        airflow_repo = "https://github.com/cjsimm/titanic-airflow.git"
        airflow_make_command = "make up"
        env_file_string = <<-EOT
        AIRFLOW_CONN_POSTGRES_DEFAULT=postgres://airflow:airflow@localhost:5439/airflow
        EOT
    }
}