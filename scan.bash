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
#echo ""
sleep 2 
command -v trivy > /dev/null 2>&1 || MISSING_PACKAGES+=("trivy")
if [[ ! -z "$MISSING_PACKAGES" ]]; then
  error "you need to install trivy!"
fi
info "This script scans a list of container images using Aqua Security's trivy CLI tool - https://github.com/aquasecurity/trivy"
#echo ""
sleep 2
#info "######## List of images to scan:"
#info "$(cat $1)"
sleep 2
for i in $(cat $1); do
  info "----- Pull image -----"
  docker pull $i
  if [ $? == 0 ]
    then
      #echo ""
      info "----- Show age -----"
      docker image ls $i --format 'Image: {{.Repository}}:{{.Tag}} was created {{.CreatedSince}}'
      #echo ""
      info "----- Scan image -----"
      trivy $i
    else
      PULLERROR=true
      #echo ""
      warn "----- ERROR with pulling image -----"
      info "----- -> Proceeding with next image -----"
  fi
done

if ( $PULLERROR )
  then
    #echo ""
    warn "######## ATTENTION: The script was not able to pull all images! Please check the output."
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