#!/bin/bash

FILE_NAME=deploy-dev.sh

# Specify an AWS Profile to use
AWS_PROFILE=

# Stack name to be built
STACK_NAME=

#Specify an email
EMAIL=

# Specify a hosted zone to create the required resources.
HOSTED_ZONE=

#S3 bucket to house the cloudformation templates.
S3_BUCKET_STACK=$STACK_NAME-sources

# Domain name
DNAME=


if [[ -z $AWS_PROFILE ]]; then
  echo "`date`-$FILE_NAME: Please enter a valid AWS_PROFILE to use."
fi

if [[ -z $STACK_NAME ]]; then
  echo "`date`-$FILE_NAME: Please enter a valid STACK_NAME to use."
fi

if [[ -z $EMAIL ]]; then
  echo "`date`-$FILE_NAME: Please enter a valid EMAIL to use."
fi

if [[ -z $HOSTED_ZONE ]]; then
  echo "`date`-$FILE_NAME: Please enter a valid HOSTED_ZONE to use."
fi

if [[ -z $DNAME ]]; then
  echo "`date`-$FILE_NAME: Please enter a valid DNAME to use."
fi


echo "`date`-$FILE_NAME: ./setup.sh -e $EMAIL -p $AWS_PROFILE -h $HOSTED_ZONE -s $STACK_NAME -d $DNAME" 
./setup.sh -e $EMAIL -p $AWS_PROFILE -h $HOSTED_ZONE -s $STACK_NAME -d $DNAME