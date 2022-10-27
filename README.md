# Contact form email notification

Send an email notification when a user POSTs a "contact us" form to a Lambda
Function endpoint using this CloudFormation template.

This template assumes you have a custom domain at which you want to receive
email. You could adjust the `SESEmailIdentityFromIdentity` resource in the
template to be an email address instead of a domain. However, unless you control
the domain of the email address, you will not be able to verify the source from
which SES sends the email. Without verification, many email providers will drop
the message or put it in a junk/spam folder.

## Configuration

Modify `params.example.json` with your desired values and rename the file to
`params.json`.

### SSM Parameter Store

Run `sh shell-scripts/create-docker-hub-password-param.sh` to securely store
your Docker Hub password in SSM Parameter Store.

### GitHub

You must provide AWS with access to the GitHub repository set in the `GitHubSourceHTTPS`
parameter. You can provide access by visiting the AWS Console CodeBuild view and
clicking to create a build project. Do not fill out any fields, instead scroll to
the "Source" heading and connect to GitHub. Once you successfully connect, you
can close the browser tab.

### SES

You must verify the domain of the email address you are using. You can do this
by adjusting the domain's DNS configuration according to the settings displayed
in the AWS SES Console (must create stack first).

## Deploy

To create the initial CloudFormation stack, run the command below from the root
of the repository.

> Note: The stack will fail if you do not initially run it with the
> `HasCodeBuildRun` parameter set to `"false"`. Once you perform the initial create,
> visit CodeBuild and start a build. This will publish the Docker image to AWS ECR
> using the `buildspec.yml` from the repository set via the `GitHubSourceHTTPS`
> parameter. After the image is in ECR, set the `HasCodeBuildRun` parameter to
> `"true"` and update the stack.

```console
aws cloudformation create-stack --stack-name ContactFormHandler \
  --template-body file://template.yml --parameters file://params.json \
  --capabilities CAPABILITY_NAMED_IAM
```

### Update

To update the stack, run the command below from the root of the repository:

```console
aws cloudformation update-stack --stack-name ContactFormHandler \
  --template-body file://template.yml --parameters file://params.json \
  --capabilities CAPABILITY_NAMED_IAM
```
