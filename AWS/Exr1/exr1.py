import boto3

# Let's use Amazon S3
ec2_region_us_east = boto3.resource('ec2',region_name='us-east-1')
ec2_all = boto3.resource('ec2')

instances = ec2_region_us_east.instances.all()
for instance in instances:
    print(instance.id, instance.private_ip_address)

instances_all = ec2_all.instances.all()
for instance in instances_all:
    print(instance.id, instance.private_ip_address)