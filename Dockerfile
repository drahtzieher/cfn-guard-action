ARG CFN_GUARD_LINK
# Container image that runs your code
FROM $CFN_GUARD_LINK

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
