# App Stack

* [Template](./../templates/bbb-on-aws-bbbsingle.template.yaml)

## Summary

| Resource | Usage | Values
| ------------- | ------------- | ------------- |
| Autoscaling group |  | Refer CF script |
| EC2 instance profile |  | Refer CF script
| EC2 Role |  | Refer CF script
| Autoscaling group Launch configuration |  | Refer CF script |


## EC2 Role

* AmazonSSMManagedInstanceCore
* Inline policy

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:ChangeResourceRecordSets",
                "route53:GetHostedZone",
                "route53:ListResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/Z06535511CU5UKTIIP8CL",
            "Effect": "Allow"
        },
        {
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Resource": [
                "arn:aws:secretsmanager:us-east-1:716927497993:secret:BBBTurnSecret-Wuzjzmc9OpP0-3Q2l0Z"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::bbb-dev-sources-bbbstackbucket-86bkghul9d5f/*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": [
                "arn:aws:ssm:us-east-1:716927497993:parameter/turnhostname"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:CreateLogGroup",
                "logs:GetLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:716927497993:log-group:/bbb-dev/systemlogs:*",
                "arn:aws:logs:us-east-1:716927497993:log-group:/bbb-dev/applicationlogs:*"
            ],
            "Effect": "Allow"
        }
    ]
}
```