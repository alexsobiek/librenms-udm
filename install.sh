#!/bin/bash

INSTALL_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $INSTALL_PATH/env.sh
source $INSTALL_PATH/snmp/snmpd.sh
source $INSTALL_PATH/api.sh

install() {
    run_snmpd
    api_add_device
}