# AMI Finder Stack

## References

* [Template](./../templates/bbb-on-aws-ses.template.yaml)


## Summary

| Resource | Usage | Values
| ------------- | ------------- | ------------- |
| Secret Provider Log Group | Secret Provider | Refer CF script |
| Secret Provider Lambda Role | Lambda Role | Refer CF script |
| Secret Provider | SES Provider | Refer CF script |
| SES Provider Log group | Log Group | Refer CF script |
| SES Provider Lambda Role | IAM Role | Refer CF script |
| SES Provider | SES Provider | Refer CF script |



##### Lambda Role

##### AWS Lambda basic execution role

* AWSLambdaBasicExecutionRole
* Inline policy describing

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ses:VerifyDomainDkim",
                "ses:DeleteIdentity",
                "ses:ListIdentities",
                "ses:VerifyDomainIdentity",
                "ses:DescribeActiveReceiptRuleSet",
                "ses:SetActiveReceiptRuleSet",
                "ses:GetIdentityVerificationAttributes",
                "ses:GetIdentityNotificationAttributes",
                "ses:SetIdentityNotificationTopic",
                "ses:SetIdentityHeadersInNotificationsEnabled",
                "ses:SetIdentityFeedbackForwardingEnabled"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "route53:GetHostedZone",
                "route53:ChangeResourceRecordSets",
                "route53:ListResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/Z06535511CU5UKTIIP8CL",
            "Effect": "Allow"
        },
        {
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": [
                "arn:aws:lambda:us-east-1:716927497993:function:bbbexample-BBBSESProviderStack-1FF1NCRGY0SXA-ses-provider"
            ],
            "Effect": "Allow"
        }
    ]
}
```