#!/usr/bin/env bash
# title          :ECNN Classification Helper
# description    :This script will analyze a github repository 
#                 based on the SFDC ECCN standards and generate a CSV file
# file_nam       :eccn-classification.sh
# author         :Adrian Puente Z.
# date           :20210614
# version        :1.0
# bash_version   :GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)
#==================================================================

set -uo pipefail
#trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
TRUE=0
FALSE=1

for repo in $(cat ${1})
do
  echo "========== ${repo} =========="
  ./eccn-classification.sh ${repo}
done

outputdir=${1}-list
[ -d ${outputdir} -o -f ${outputdir} ] && rm -vfr ${outputdir} 1>/dev/null 2>&1
mkdir -p ${outputdir}

for dir in $(find . -type d -name "*-out")
do
  cat ${dir}/*FINAL.csv >> ${outputdir}/${1}-FINAL.csv 
done

echo  "Final report in ${outputdir}/${1}-FINAL.csv"
