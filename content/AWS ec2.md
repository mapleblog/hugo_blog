# AWS 

### How to connect EC2 via private IP

1. Create EC2 instance first



### Option 1: EC2 Instance Connect (EIC) Endpoint (Recommended)

This modern method uses the [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/ec2-instance-connect/ssh.html) to establish a private secure tunnel. It requires **no public IP, no bastion host, and no internet gateway** in your VPC.

1. Setup the Endpoint
   - Go to the **VPC Console**.
   - Click **Endpoints** > **Create endpoint**.
   - Name it and select **EC2 Instance Connect Endpoint** as the service category.
   - Choose your VPC and the private subnet where your instance lives.
   - Assign a security group that allows outbound traffic to your destination instance.

2. Modify the security group for EC2 instance (i-01144b880def7327b)
   1. Go to the AWS console and locate your EC2 instance `i-01144b880def7327b`
   2. Click the Security tab below, then click the security group ID associated with it.
   3. Click Edit inbound rules
   4. Add or modify a rule, strictly set to the following parameters：
      - **Type**: `SSH`
      - **Protocol**: `TCP` (自动填充)
      - **Port range **: `22` (自动填充)
      - **Source **: Select `Custom`, then enter the EICE security group ID from your screenshot in the input box on the right: `sg-0ca894537eb406c25` (the console usually automatically pops up a prompt for you to click and select when entering).

3. Run the SSH Command

   - Use the built-in `aws ec2-instance-connect ssh` wrapper command from your local machine terminal

     ```bash
     bashaws ec2-instance-connect ssh --instance-id <ec2_instance_ID> --private-ip-address <ec2_intance_private_IP>
     ```

     



