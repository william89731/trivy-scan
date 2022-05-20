#!/bin/bash
PULLERROR=false
function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }
declare -a MISSING_PACKAGES

echo "

████████╗██████╗ ██╗██╗   ██╗██╗   ██╗
╚══██╔══╝██╔══██╗██║██║   ██║╚██╗ ██╔╝
   ██║   ██████╔╝██║██║   ██║ ╚████╔╝ 
   ██║   ██╔══██╗██║╚██╗ ██╔╝  ╚██╔╝  
   ██║   ██║  ██║██║ ╚████╔╝    ██║   
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝     ╚═╝  
"

sleep 2 
command -v trivy > /dev/null 2>&1 || MISSING_PACKAGES+=("trivy")
if [[ ! -z "$MISSING_PACKAGES" ]]; then
  error "you need to install trivy!"
fi
info "ready to scan"
sleep 2
for i in $(cat $1); do
  info "Pull image"
  docker pull $i
  if [ $? == 0 ]
    then
      info "Show age"
      docker image ls $i --format 'Image: {{.Repository}}:{{.Tag}} was created {{.CreatedSince}}'
      
      info "Scan image"
      trivy $i
    else
      PULLERROR=true
      warn "ERROR pull image"
      info "-->next image"
  fi
done

if ( $PULLERROR )
  then
    warn "check your list because there is an invalid image"
fi
sleep 2
echo "
 ██████╗  ██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███████╗
██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
██║  ███╗██║   ██║██║   ██║██║  ██║██████╔╝ ╚████╔╝ █████╗  
██║   ██║██║   ██║██║   ██║██║  ██║██╔══██╗  ╚██╔╝  ██╔══╝  
╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║   ███████╗
 ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚══════╝
 "