# First parameter
$KeyPairName = New-Object Amazon.CloudFormation.Model.Parameter
$KeyPairName.ParameterKey = "KeyPairName"
$KeyPairName.ParameterValue = "pwsh-cfn"

$WindowsStackTemplate = Get-Content -Path ./sample_Windows_ec2.yml -Raw

New-CFNStack -StackName SampleWindowsStack -TemplateBody $WindowsStackTemplate -Parameters $KeyPairName
