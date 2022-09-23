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
clear
sleep 10 & PID=$! 
echo "trivy is an opensource project for scanning vulnerabilities in container images, file systems, and Git repositories"
printf "["
while kill -0 $PID 2> /dev/null; do 
    printf  "▓"
    sleep 1
done
printf "] "
printf "\n"

function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }
PULLERROR=false

info "read images-list"
sleep 2
truncate -s 0 ~/trivy-scan/report.txt 
set -o noclobber
for image in $(cat $1); do
  echo ""
  info "$image"
  
  docker pull $image
  if [ $? == 0 ]
    then
      echo "" >>  ~/trivy-scan/report.txt
      docker image ls $image --format '{{.Repository}}  was created {{.CreatedSince}}' >>  ~/trivy-scan/report.txt
      echo "scan.."
      docker run --rm -v ~/trivy-scan/trivy_database:/root/.cache/ -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy  image --skip-dirs usr/ --skip-dirs helm $image >>  ~/trivy-scan/report.txt
      echo "
      #######################################################################################################################################################
      #######################################################################################################################################################" >>  ~/trivy-scan/report.txt
      
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
info "see result in report.txt"

date  >>  ~/trivy-scan/report.txt
