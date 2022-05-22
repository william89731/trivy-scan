#!/bin/bash

echo "

████████╗██████╗ ██╗██╗   ██╗██╗   ██╗
╚══██╔══╝██╔══██╗██║██║   ██║╚██╗ ██╔╝
   ██║   ██████╔╝██║██║   ██║ ╚████╔╝ 
   ██║   ██╔══██╗██║╚██╗ ██╔╝  ╚██╔╝  
   ██║   ██║  ██║██║ ╚████╔╝    ██║   
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝     ╚═╝  
"
sleep 4

function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }
declare -a MISSING_PACKAGES
PULLERROR=false

info "ready to scan"
sleep 3
truncate -s 0 ~/trivy-scan/report.txt 
set -o noclobber
for image in $(cat $1); do
  echo ""
  info "$image"
  echo "scan.."
  docker pull $image
  if [ $? == 0 ]
    then
     # docker image ls $image --format 'Image: {{.Repository}}:{{.Tag}} was created {{.CreatedSince}}' >>  ~/trivy-scan/report.txt
      echo "$image" >>  ~/trivy-scan/report.txt
      docker image ls $image --format 'was created {{.CreatedSince}}' >>  ~/trivy-scan/report.txt
      docker run --rm -v ~/trivy_database:/root/.cache/ aquasec/trivy  image  $image >>  ~/trivy-scan/report.txt
    else
      PULLERROR=true
      warn "ERROR with pulling image"
      echo ""
  fi
done

if ( $PULLERROR )
  then
    warn "found invalid image.check your list"
fi
echo ""
echo ""
echo "see result in report.txt"

date  >>  ~/trivy-scan/report.txt
