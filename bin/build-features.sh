#!/bin/bash

FDIRS=(clinical-features demographics severity-scores)

LOG_FLAGS=(v g)
LOG_ARGS=("/dev/null" "/dev/null")
LOG_OPTS=$(printf "%s:" ${LOG_FLAGS[@]})

IO_FLAGS=(h p c d f o)
IO_ARGS=(false false false "mimic" false false)
IO_OPTS=$(printf "%s:" ${IO_FLAGS[@]})

for fdir in ${FDIRS[@]}; do
    bdir=data/cohort-build/$fdir
    mkdir -p $bdir
    for sql in $(find $fdir -type f -iname "*.sql"); do
        IO_ARGS[4]=$sql
        IO_ARGS[5]=$bdir/$(basename $sql .sql).csv
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

        echo "Building features..."
        echo -e "\t$PGS_CMD"
        eval "PGOPTIONS=$PGOPTIONS" $PGS_CMD
    done
done
