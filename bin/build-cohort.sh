tmp_out="/var/tmp/cohort.temp.csv"

# # Bash<4.0.0 does not suport assoc. arrays
# LOG_ARGS=(
#   [v]="/dev/null"
#   [g]="/dev/null"
# )
# IO_FLAGS=(
#   [h]=false
#   [p]=false
#   [c]=false
#   [d]="mimic"
#   [s]="mimiciii"
#   [f]="cohort.sql"
#   [o]="data/cohort-build/cohort.csv"
# )

LOG_FLAGS=(v g)
LOG_ARGS=("/dev/null" "/dev/null")

IO_FLAGS=(h p c d s f o)
IO_ARGS=(false false false "mimic" "mimiciii" "cohort.sql" "data/cohort-build/cohort.csv")

while getopts ":${IO_FLAGS[@]}:${LOG_FLAGS[@]}" flag; do
  case $flag in 
    @("${IO_FLAGS[@]}" ) 
      idx=$(indexof $flag)
      IO_ARGS[$fidx]=$OPTARG; break;;
    @("${!LOG_ARGS[@]}" ) 
      idx=$(indexof $flag)  
      LOG_ARGS[$idx]=$OPTARG; break;;
    \?) errmsg=$(printf "\nInvalid flag -%s\n" "${$flag}") 
        "${errmsg}" >> LOG_ARGS["v"] 
        "${errmsg}" >> LOG_ARGS["g"]
        exit 1;;
  esac
done

PGS_CMD=$(
  for i in "${!IO_FLAGS[@]}" do 
    flag=${IO_FLAGS[$i]}
    arg=${IO_ARGS[$i]} 
    if [$arg] then 
      printf "\-%s %s" $flag $arg
    fi
  done
)

echo $PGS_CMD
# eval $(printf "psql %s" $PGS_CMD)