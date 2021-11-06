#!/usr/bin/env bash

# Run pwnbox container in docker.
# 
# Store your .gdbinit, .radare2rc, .vimrc, etc in a ./rc directory and 
# the contents will be copied to /root/ in the container.


ESC="\x1B["
RESET=$ESC"39m"
RED=$ESC"31m"
GREEN=$ESC"32m"
BLUE=$ESC"34m"

script_dir=$(dirname $0)
rc_dir="${script_dir}/rc"

# check if jq is installed
which jq > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo -e "${RED}Install jq and try again${RESET}"
    echo -e "${RED}macOS: brew install jq${RESET}"
    echo -e "${RED}Debian/Ubuntu: sudo apt install jq${RESET}"
    echo -e "${RED}Fedora: sudo dnf install jq${RESET}"
    exit 0
fi 

if [[ -z ${1} ]]; then
    echo -e "${RED}Missing argument CTF name.${RESET}"
    exit 0
fi

ctf_name=${1}

# Create a volume for this container 
docker create -v /root/work --name ${ctf_name}_data pwnbox

# Get the volume name for the delete script
vol_name=`docker inspect ${ctf_name}_data | jq '.[].Mounts[].Name' | sed 's/\"//g'`

# Create docker container and run in the background
# Add this if you need to modify anything in /proc:  --privileged 
docker run -it \
    -h ${ctf_name} \
    -d \
    --security-opt seccomp:unconfined \
    --name ${ctf_name} \
    --volumes-from ${ctf_name}_data \
    --privileged \
    pwnbox

# Tar config files in rc and extract it into the container
if [[ -d ${rc_dir} ]]; then
    cd "${rc_dir}"
    [[ -f rc.tar ]] && rm -f rc.tar

    for i in .*; do
        if [[ ! ${i} == "." && ! ${i} == ".." ]]; then
            tar rf rc.tar ${i}
        fi
    done
    cat rc.tar | docker cp - ${ctf_name}:/root/
    rm -f rc.tar
    cd - > /dev/null 2>&1
else
    echo -e "${RED}No rc directory found. Nothing to copy to container.${RESET}"
fi

# Create script to start/delete container
cat << EOF > ${ctf_name}.sh
#!/bin/bash

if [[ "\$1" == "-h" ]] || [[ "\$1" == "--help" ]];then
  echo "\
Usage:
To run:
\$0
To delete all files:
\$0 delete"
fi

if [[ -z "\$1" ]] || [[ "\$1" == "run" ]]; then
  if docker exec -it ${ctf_name} tmux ls >/dev/null 2>&1; then
    docker exec -it ${ctf_name} tmux -u a -d -t ${ctf_name}
  else
    echo "No tmux session found. Starting a new one."
    docker exec -it ${ctf_name} tmux -u new -s ${ctf_name} -c /root/work
  fi
fi

if [ "\$1" == "delete" ]; then
  echo "Removing ${ctf_name} containers and volumes"
  read -ep "You sure?(y/n): " confirm
  [[ \$confirm =~ ^[Nn]$ ]] && { echo "Exiting...";exit 0; }
  docker stop ${ctf_name}
  docker rm ${ctf_name}
  docker rm ${ctf_name}_data
  docker volume rm ${vol_name}
  rm -f ${ctf_name}.sh
  echo "All files deleted"
fi
EOF
chmod 755 ${ctf_name}.sh

# Drop into a tmux shell
echo -e "\
${GREEN}                         ______               ${RESET}
${GREEN}___________      ___________  /___________  __${RESET}
${GREEN}___  __ \\_ | /| / /_  __ \\_  __ \\  __ \\_  |/_/${RESET}
${GREEN}__  /_/ /_ |/ |/ /_  / / /  /_/ / /_/ /_>  <  ${RESET}
${GREEN}_  .___/____/|__/ /_/ /_//_.___/\\____//_/|_|  ${RESET}
${GREEN}/_/                           by superkojiman  ${RESET}
${GREEN}                            forked by R3tr074  ${RESET}
"

echo -e "Docker created with success, run ${GREEN}${ctf_name}.sh${RESET} to start"

#docker exec -it ${ctf_name} tmux -u new -s ${ctf_name} -c /root/work
