#!/bin/bash

abspath() {
  # $1 : relative filename
  if [ -d "${1%/*}" ]; then
    echo "$(cd ${1%/*}; pwd)/${1##*/}"
  fi
}

FDIRS=(clinical-features demographics severity-scores)

LOG_FLAGS=(v g)
LOG_ARGS=("/dev/null" "/dev/null")
LOG_OPTS=$(printf "%s:" ${LOG_FLAGS[@]})

IO_FLAGS=(h p d)
IO_ARGS=(false false "mimic")
IO_OPTS=$(printf "%s:" ${IO_FLAGS[@]})

for fdir in ${FDIRS[@]}; do
    bdir=data/cohort-build/$fdir
    mkdir -p $bdir
    for sql in $(find $fdir -type f -iname "*.sql"); do
        EXPORT_FROM=$(awk '/CREATE MATERIALIZED VIEW/ {print $4}' $(abspath $sql))
        EXPORT_TO=$(abspath $bdir/$(basename $sql .sql).csv)
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
        echo $(printf "Exporting %s..." $(basename $sql .sql))
        echo "PGOPTIONS=$PGOPTIONS" $PGS_CMD -c '"COPY (select * from '$EXPORT_FROM') TO' "'$EXPORT_TO'" 'WITH CSV HEADER;"'
    done
done
