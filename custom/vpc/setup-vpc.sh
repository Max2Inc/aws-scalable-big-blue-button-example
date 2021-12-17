#!/bin/bash
# This is a simple bash script for the BBB Application Infrastructure deployment. 

ERROR_COUNT=0; 

if [[ $# -lt 5 ]] ; then
    echo 'arguments missing, please provide at least email (-e), the aws profile string (-p), the domain name (-d), the deployment Stack Name (-s) and the hosted zone to be used (-h)'
    exit 1
fi

while getopts ":p:e:h:s:d:" opt; do
  case $opt in
    p) BBBPROFILE="$OPTARG"
    ;;
    s) BBBSTACK="$OPTARG"
    ;;
    \?) echo "`date`: Invalid option -$OPTARG" >&2
    ;;
  esac
done

if ! [ -x "$(command -v aws)" ]; then
  echo '`date`: ERROR: aws cli is not installed.' >&2
  exit 1
fi

echo "`date`: using AWS Profile $BBBPROFILE"

# Loop through the YAML templates in this repository
for TEMPLATE in $(find . -name 'vpc.template.yaml'); do 

    # Validate the template with CloudFormation
    ERRORS=$(aws cloudformation validate-template --profile=$BBBPROFILE --template-body file://$TEMPLATE 2>&1 >/dev/null); 
    if [ "$?" -gt "0" ]; then 
        ((ERROR_COUNT++));
        echo "`date`: [fail] $TEMPLATE: $ERRORS";
    else 
        echo "`date`: [pass] $TEMPLATE";
    fi; 
    
done; 

# Error out if templates are not validate. 
echo "$ERROR_COUNT template validation error(s)"; 
if [ "$ERROR_COUNT" -gt 0 ]; 
    then exit 1; 
fi

echo "`date`: Validating of AWS CloudFormation templates finished"


# Deploy the Needed Buckets for the later build 
echo "`date`: Deploying VPC"
BBBPREPSTACK="${BBBSTACK}-Sources"
aws cloudformation deploy --stack-name $BBBPREPSTACK --profile=$BBBPROFILE --template ./templates/bucket-template.yaml
echo "`date`: Deployment done"

# get the s3 bucket name out of the deployment.
SOURCE=`aws cloudformation describe-stacks --profile=$BBBPROFILE --query "Stacks[0].Outputs[0].OutputValue" --stack-name $BBBPREPSTACK`

SOURCE=`echo "${SOURCE//\"}"`

# we will upload the needed CFN Templates to S3 containing the IaaC Code which deploys the actual infrastructure.
# This will error out if the source files are missing. 
echo "`date`: ##################################################"
echo "`date`: Copy Files to the S3 Bucket for further usage"
echo "`date`: ##################################################"
if [ -e . ]
then
    echo "`date`: ##################################################"
    aws s3 sync --profile=$BBBPROFILE --exclude=".DS_Store" ./templates s3://$SOURCE
    echo "`date`: ##################################################"
else
    echo "`date`: BBB code source file missing"
    echo "`date`: ##################################################"
    exit 1
fi
echo "`date`: ##################################################"
echo "`date`: File Copy finished"

# Setting the dynamic Parameters for the Deployment
PARAMETERS="BBBStackBucketStack=$BBBSTACK-Sources"

# Deploy the BBB infrastructure. 
echo "`date`: Building the BBB Environment"
echo "`date`: ##################################################"
aws cloudformation deploy --profile=$BBBPROFILE --stack-name $BBBSTACK \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides $PARAMETERS \
    $(jq -r '.Parameters | to_entries | map("\(.key)=\(.value)") | join(" ")' bbb-on-aws-param.json) \
    --template ./bbb-on-aws-root.template.yaml

echo "`date`: ##################################################"
echo "`date`: Deployment finished"

exit 0