## WeaveSocks Demo

### Installation
run the command `./weavesocks-demo-cli.sh setup`

This will create a cloudformation stack containing EC2 instances, an ECS cluster and all of weavesock's services.

The command will wait until the stack creation is ready and print the dns of the weavesock site (this takes several minutes)

### Browsing
run `./weavesocks-demo-cli.sh dns` to get the domain name for the weavesock shop website

### Uninstalling
Make sure no agents are deployed before uninstalling!

run `./weavesocks-demo-cli.sh destroy` 

this will take several minutes to complete

### Tapping
Once the stack is successfully created, run `up9 agent:ecs-prepare-agent-ec2 weavesocks-demo-agent {CLUSTER_ID} {VPC_ID} {SUBNET0_ID}` and follow the instructions in its output

To get the necessary parameters, run `./weavesocks-demo-cli.sh resources`

If everything worked properly you should see tapping sources for the agent `weavesocks-demo-agent` in the /tapping page of the env you were authenticated to in CLI