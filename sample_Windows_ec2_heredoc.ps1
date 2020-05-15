# First parameter
$KeyPairName = New-Object Amazon.CloudFormation.Model.Parameter
$KeyPairName.ParameterKey = "KeyPairName"
$KeyPairName.ParameterValue = "pwsh-cfn"

$sampleWindowsstack = @{
    StackName = 'sampleWindowsec2'
    Parameter = $KeyPairName
    TemplateBody = @'
Parameters:
  LatestAmiId:
    Type: 'AWS::SSM::Parameter::Value<AWS::EC2::Image::Id>'
    Default: '/aws/service/ami-windows-latest/Windows_Server-2019-English-Core-Base'
  KeyPairName:
    Description: Name of an existing EC2 KeyPair
    Type: AWS::EC2::KeyPair::KeyName
Resources:
  Ec2Instance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: !Ref LatestAmiId
      InstanceType: t2.micro
      Tags:
        - Key: Name
          Value: !Join
           - ""
           - - "dev-web-01"
             - !Ref AWS::Region
      SecurityGroups:
        - !Ref MySecurityGroup
      KeyName: !Ref KeyPairName
      UserData:
        'Fn::Base64':
          !Sub |
            <powershell>
            Install-WindowsFeature web-server -IncludeAllSubFeature;
            Install-WindowsFeature  Web-Mgmt-Tools -IncludeAllSubFeature;
            Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
            </powershell>
  MySecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupName: SimpleWinGroup
      GroupDescription: Enables WinRM-HTTP traffic via port 5985 and RDP 3389
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 5985
          ToPort: 5985
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: 3389
          ToPort: 3389
          CidrIp: 0.0.0.0/0
Outputs:
  ServerDns:
    Value: !GetAtt
      - Ec2Instance
      - PublicDnsName

'@
}

New-CFNStack @sampleWindowsstack
