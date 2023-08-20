A terraform module used to spin up a multi-container docker config on an AWS EC2 instance. 

launch_script is run after the instance is spun up, cloning an airflow container repo of the user's choice and running a makefile command to initialize.

the default launch script dumps a string into an env file in order
to pass variables into the airflow containers via terraform. 