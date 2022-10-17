# Contact form email notification

CloudFormation template to send an email notification when a user POSTs a
contact form.

## Configuration

Modify `params.example.json` with your desired values and rename the file to
`params.json`.

## Deploy

To create the initial CloudFormation stack, run the command below from the root
of the repository:

````console
aws cloudformation create-stack --stack-name ContactFormHandler \
  --template-body file://template.yml --parameters file://params.json \
  --capabilities CAPABILITY_NAMED_IAM
```

To update the stack, run the command below from the root of the repository:

```console
aws cloudformation update-stack --stack-name ContactFormHandler \
  --template-body file://template.yml --parameters file://params.json \
  --capabilities CAPABILITY_NAMED_IAM
````
