# Single deployment

During a Single Deployment the following resources are created

### Stacks created

* [Network Provider](help/single/1-Network-Provider.md)
* [SES Provider](help/single/2-SES-Provider.md)
* [AMI Finder](help/single/3-AMI-Finder.md)
* [Security Group Provider](help/single/4-Security-Group.md)
* [Turn Stack](help/single/5-Turn-stack.md)
* [App Stack](help/single/6-BBB-App-single.md)

# To run a single deployment refer to the following config parameters in bbb-on-aws-param.json

```json
{
  "Parameters" : {
    "BBBApplicationVersion": "bionic-230",
    "BBBApplicationInstanceOSVersion": "bionic-18.04",
    "BBBInstanceKey" : "pictolearn-ec2",
    "BBBTurnInstanceOSVersion": "focal-20.04",
    "BBBECSInstanceType": "fargate",
    "BBBApplicationInstanceType": "t3a.medium",
    "BBBApplicationDataVolumeSize": 50,
    "BBBApplicationRootVolumeSize": 20,
    "BBBTurnInstanceType": "t3a.micro",
    "BBBTurnInstanceKey" : "pictolearn-ec2",
    "BBBDBInstanceType": "serverless",
    "BBBServerlessAuroraMinCapacity": 2,
    "BBBServerlessAuroraMaxCapacity": 4,
    "BBBCACHEDBInstanceType": "cache.t3.micro",
    "BBBVPCs": "10.1.0.0/16",
    "BBBPrivateApplicationSubnets": "10.1.5.0/24,10.1.6.0/24,10.1.7.0/24",
    "BBBPrivateDBSubnets": "10.1.9.0/24,10.1.10.0/24,10.1.11.0/24",
    "BBBPublicApplicationSubnets": "10.1.15.0/24,10.1.16.0/24,10.1.17.0/24",
    "BBBNumberOfAZs": 1,
    "BBBECSMaxInstances": 1,
    "BBBECSMinInstances": 1,
    "BBBECSDesiredInstances": 1,
    "BBBApplicationMaxInstances": 1,
    "BBBApplicationMinInstances": 1,
    "BBBApplicationDesiredInstances": 1,
    "BBBTurnMaxInstances": 1,
    "BBBTurnMinInstances": 1,
    "BBBTurnDesiredInstances": 1,
    "BBBDBName": "frontendapp",
    "BBBDBEngineVersion": "10.14",
    "BBBEnvironmentStage": "dev",
    "BBBEnvironmentName": "bbbonaws",
    "BBBEnvironmentType": "single",
    "BBBgreenlightImage": "bigbluebutton/greenlight:v2",
    "BBBScaleliteApiImage": "blindsidenetwks/scalelite:v1.3-api",
    "BBBScaleliteNginxImage": "blindsidenetwks/scalelite:v1.3-nginx",
    "BBBScalelitePollerImage": "blindsidenetwks/scalelite:v1.3-poller",
    "BBBScaleliteImporterImage": "blindsidenetwks/scalelite:v1.3-recording-importer",
    "BBBCacheAZMode": "cross-az",
    "BBBGreenlightMemory": 1024,
    "BBBGreenlightCPU": 512,
    "BBBScaleliteMemory": 2048,
    "BBBScaleliteCPU": 1024,
    "DataDogMonitorFlag": false
  }
}
```