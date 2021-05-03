#!/bin/bash

if [ "$DBT_EXTERNAL_TABLES_CI_INSTALL_CUE" == "1" ]; then
    wget https://github.com/cuelang/cue/releases/download/v0.2.2/cue_0.2.2_Linux_x86_64.tar.gz
    tar xvfz cue_0.2.2_Linux_x86_64.tar.gz
    sudo cp cue /usr/local/bin
fi

cue vet sample_sources/spark.yml spec.cue
cue vet sample_sources/redshift.yml spec.cue
cue vet sample_sources/snowflake.yml spec.cue
