#!/usr/bin/env bash

export MKL_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1



date

num_rounds=600
batch_size=10
num_epochs=1
clients_per_round=50
lr=2.0
lr_decay=2
decay_lr_every=200
reg=0.0


model="erm_lstm_log_reg"

dataset="sent140"

outf="outputs/exp/sent140/nn_vanilla_fl/"
logf="outputs/exp/sent140/nn_vanilla_fl/logs"

main_args=" -dataset ${dataset} -model ${model} "
options_basic=" --num-rounds ${num_rounds} -lr ${lr} --lr-decay ${lr_decay} --decay-lr-every ${decay_lr_every} --eval-every 25 --num_epochs ${num_epochs} --full_record True "


for seed in 1 2 3 4 5
do

# ERM # by default, run_simplicial_fl=False
options=" ${options_basic}  --clients-per-round ${clients_per_round} --seed $seed "

time python main.py ${main_args} $options  -reg_param $reg --output_summary_file ${outf}${dataset}_${model}_${reg}_ERM_${seed}  > ${logf}_${dataset}_${model}_${reg}_ERM_${seed} 2>&1

done

date
