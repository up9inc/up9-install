## Commands

Perform all commands from aws/up9 dir.

```
cd aws/up9
```

### Local Templates

Create a new stack from a local template file:

```
# <STACK_NAME> is the stack name to set (you choose)
# <TEMPLATE_NAME>.yaml is the template file and <TEMPLATE_NAME>_values.json is the parameters file
./install_from_local <STACK_NAME> <TEMPLATE_NAME>
```

### S3 Templates

Upload template to s3 bucket:

```
# <TEMPLATE_NAME>.yaml is the template file
./upload_template.sh <TEMPLATE_NAME>
```

Create a new stack from a template in an S3 bucket:

```
# <STACK_NAME> is the stack name to set (you choose)
# up9/templates/<TEMPLATE_NAME> is the template bucket and <TEMPLATE_NAME>_values.json is the parameters file
./install <STACK_NAME> <TEMPLATE_NAME>
```

### Installation

#### EC2
Install in the following order:

1. vpc
2. cluster
3. ec2/trdemo
4. ec2/collector
5. ec2/agent

#### Fargate
Install in the following order:

1. vpc
2. cluster
3. fargate/trdemo
4. fargate/collector
5. fargate/agent

Use CloudFormation console to fill out missing values in the values JSON: once a stack reaches `CREATE_COMPLETE` status,
all the IDs of the resources it created can be found in the Resources tab.
