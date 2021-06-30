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

set -euo pipefail
#trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
TRUE=0
FALSE=1

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [repository]

Script description here.

Available options:

-h, --help      Print this help and exit
The repository can be:
* repo.zip - the repository in a zip file
* repo directory - a local directory containing the files
* https://github.com/repo - a remote repository

EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}


msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  flag=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage 
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

parse_params "$@"
reponame=$(echo ${1} | sed 's/^.*://g;s/\.git$//g')
repo=${1}
outputdir=${repo}-out
tmpdir=$(mktemp -d -t eccn-XXXXXXXXXX)

# script logic here
msg "Processing ${repo}"
regex='(https?:|git)//[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

    if [[ ${repo}} =~ ${1} ]]
    then
        pushd ${tmpdir} >/dev/null 2>&1
        msg "Cloning with command git, this depends on how the command is configured."
        git clone ${1}
        repo1=$(echo ${repo} | sed 's/.*\///g;s/\.git//g')
        repo=${repo1}
        remote="TRUE"
        popd >/dev/null 2>&1
    elif [ -f "${repo}" ]
    then
        msg "Repo ${repo} found, analyzing"
    else
        msg "Error, ${repo} is not a valid repo."
        exit 1
    fi

outputdir=${repo}-out
[ -d ${outputdir} -o -f ${outputdir} ] && rm -vfr ${outputdir}
mkdir -p ${outputdir}

if [ -n "${remote}" ]
then
    repo1=${tmpdir}/${repo} 
    repo=${repo1}
fi

msg "Scanning for crypto"
for method in eccnstep1
do
    ./scan-for-crypto.py  --output  ${outputdir} \
                          --methods ${method} \
                          --output-existing rename \
                          -v false \
                          --source-files-only \
                          --${method}-ignore-case true \
                          ${repo}
done
[ -d ${outputdir} ] && rm -vfr ${tmpdir} > /dev/null 2>&1
msg "Files created:"
msg "$(ls -1 ${outputdir} | sed 's/^/\t* /g')"

./reporting/translate_to_csv.py -o ${outputdir} ${outputdir}/*
repo=$(echo ${repo} | sed 's/.*\///g')
cat ${outputdir}/*.csv > ${outputdir}/${repo}-FINAL.csv
NUMLINES=$(wc -l ${outputdir}/${repo}-FINAL.csv | cut -f1 -d" ")
if [ ${NUMLINES} -eq 1 ]
then
  msg "==]> Repo ${reponame} aparently has no crypto, review in detail."
else
  msg "==]> Repo ${reponame} contains ${NUMLINES} matches for crypto."
fi
msg "Final report in ${outputdir}/${repo}-FINAL.csv"
