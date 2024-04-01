# Container image that runs your code
FROM public.ecr.aws/aws-cloudformation/cloudformation-guard:3.1.0

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

ENV PATH="/usr/src/cloudformation-guard:${PATH}"

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
