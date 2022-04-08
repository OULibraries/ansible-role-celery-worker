#!/bin/bash

while getopts ":e:p:v:" opt; do
    case $opt in
        e) MAMBA_ENV_NAME="$OPTARG"
        ;;
        p) MAMBA_ROOT_PREFIX="$OPTARG"
        ;;
        v) PY_VERSION="$OPTARG"
        ;;
        \?) "Invalid option -$OPTARG" >&2
        exit 1
        ;;
    esac

    case $OPTARG in
        -*) echo "Option $opt needs a valid argument"
        exit 1
        ;;
    esac
done

PATH=/opt/oulib/micromamba/bin:$PATH

export MAMBA_ROOT_PREFIX=$MAMBA_ROOT_PREFIX

# need this for the micromamba commands to work
eval "$(micromamba shell hook -s posix)"

# create a new python environment with mamba for testing
micromamba create -y -n "$MAMBA_ENV_NAME" python="$PY_VERSION" -c conda-forge

# activate the test environment
micromamba activate "$MAMBA_ENV_NAME"
