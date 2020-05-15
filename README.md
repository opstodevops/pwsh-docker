# pwsh-docker
Code repository for PowerShell in Docker project

### Building a PWSH Docker container with AWS tools
```
docker build --rm -t pwsh:docker .
```

### Running PWSH Docker container with AWS Environment Variables
```
docker container run --rm -it --name pwsh01 \
--volume "$(pwd)":/pwsh --workdir /pwsh \
--env "AWS_ACCESS_KEY_ID=awsaccesskeyid" --env "AWS_SECRET_ACCESS_KEY=awsSecretAccessKey" --env "AWS_REGION=us-east-1" \
pwsh:docker
 ```