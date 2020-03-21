#!/bin/bash

abspath() {
  # $1 : relative filename
  if [ -d "${1%/*}" ]; then
    echo "$(cd ${1%/*}; pwd)/${1##*/}"
  fi
}

EXPORT_TO=$(abspath data/cohort-build/cohort.csv)

LOG_FLAGS=(v g)
LOG_ARGS=("/dev/null" "/dev/null")
LOG_OPTS=$(printf "%s:" ${LOG_FLAGS[@]})
LOG_CASE=$(printf "%s|" ${LOG_FLAGS[@]})

IO_FLAGS=(h p d)
IO_ARGS=(false false "mimic")
IO_OPTS=$(printf "%s:" ${IO_FLAGS[@]})

while getopts "${IO_OPTS}:${LOG_OPTS}" flag; do
    for idx in ${!IO_FLAGS[@]}; do
        if [ "${IO_FLAGS[$idx]}" = "$flag" ]; then
            IO_ARGS[$idx]=$OPTARG
        fi
    done
    for idx in ${!LOG_FLAGS[@]}; do
        if [ "${LOG_FLAGS[$idx]}" = "$flag" ]; then
            LOG_ARGS[$idx]=$OPTARG
        fi
    done
done

PGS_CMD=psql$(
    for i in ${!IO_FLAGS[@]}; do 
        flag=${IO_FLAGS[$i]} 
        arg=${IO_ARGS[$i]}
        if [ $arg != false ]; then 
            printf " -%s %s" "$flag" "$arg"; 
        fi; 
    done  
)

echo "Exporting cohort..."
eval "PGOPTIONS=$PGOPTIONS" $PGS_CMD -c '"COPY (select * from cohort) TO' "'$EXPORT_TO'" 'WITH CSV HEADER;"'

