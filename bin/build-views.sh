#!/bin/bash

LOG_FLAGS=(v g)
LOG_ARGS=("/dev/null" "/dev/null")
LOG_OPTS=$(printf "%s:" ${LOG_FLAGS[@]})

IO_FLAGS=(h p c d f)
IO_ARGS=(false false false "mimic" false)
IO_OPTS=$(printf "%s:" ${IO_FLAGS[@]})

for sql in $(find lib -type f -iname "*.sql"); do
    IO_ARGS[5]=$sql
    vname=$(basename $sql .sql)
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
                printf " -%s %s" "$flag" "$arg" 
            fi
        done
    )

    echo "Building view ..."
    echo -e "\t$PGS_CMD"
    eval "PGOPTIONS=$PGOPTIONS" $PGS_CMD
done
