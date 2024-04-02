# Container image that runs your code
FROM public.ecr.aws/aws-cloudformation/cloudformation-guard:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

ENV PATH="/usr/src/cloudformation-guard:${PATH}"

# Sets the working directory
WORKDIR /

# Installs Python (if not already installed) and any required dependencies
RUN apk add --no-cache python3
RUN apk add git

# Clone the rules repository
RUN git clone https://github.com/aws-cloudformation/aws-guard-rules-registry.git
WORKDIR /aws-guard-rules-registry
# Copy the build script to the container
RUN mv /aws-guard-rules-registry/mappings/build.py /aws-guard-rules-registry/build.py \
    && python /aws-guard-rules-registry/build.py -r 1.0.0
WORKDIR /
RUN mkdir guard-files \
    && mv /aws-guard-rules-registry/docker/output/*.guard /guard-files/ \
    && ls /guard-files


# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
