#!/usr/bin/env bash

set -e

if [[ $# -ne 3 ]]; then
    echo "Usage: ./1_coda_get.sh <coda-auth-file> <coda-v2-root> <data-root>"
    echo "Downloads coded messages datasets from Coda to '<data-root>/Coded Coda Files'"
    exit
fi

AUTH=$1
CODA_V2_ROOT=$2
DATA_ROOT=$3

./checkout_coda_v2.sh "$CODA_V2_ROOT"

DATASETS=(
    "FCDO_EiE_rqa_s10e01"
    "FCDO_EiE_rqa_s10e02"
    "FCDO_EiE_rqa_s10e02_break"
    "FCDO_EiE_rqa_s10e03"
    "FCDO_EiE_rqa_s10e04"

    "CSAP_age"
    "CSAP_gender"
    "CSAP_location"
    "CSAP_recently_displaced"
    "CSAP_children_in_school"
    "CSAP_livelihood"

    "FCDO_EiE_schools_informing_parents"
    "FCDO_EiE_issues_in_school"
)

cd "$CODA_V2_ROOT/data_tools"
git checkout "c47977d03f96ba3e97c704c967c755f0f8b666cb"  # (master which supports incremental add)

mkdir -p "$DATA_ROOT/Coded Coda Files"

for DATASET in ${DATASETS[@]}
do
    FILE="$DATA_ROOT/Coded Coda Files/$DATASET.json"

    if [ -e "$FILE" ]; then
        echo "Getting messages data from ${DATASET} (incremental update)..."
        MESSAGES=$(pipenv run python get.py --previous-export-file-path "$FILE" "$AUTH" "${DATASET}" messages)
        echo "$MESSAGES" >"$FILE"
    else
        echo "Getting messages data from ${DATASET} (full download)..."
        pipenv run python get.py "$AUTH" "${DATASET}" messages >"$FILE"
    fi

done
