#!/bin/bash

SNMP_PATH=${SNMPD_PATH:="/etc/snmp"}
SNMPD_CONFIG="$SNMP_PATH/snmpd.conf"
INTERFACE="10.28.10.1"
SNMPD_LISTEN_ADDRESS=${SNMPD_LISTEN_ADDRESS:=${INTERFACE}}


install_snmpd() {
    apt install -y snmpd
    systemctl enable snmpd
}

configure_snmpd() {
    # Replace the default agent address of 127.0.0.1 with the IP address of the interface
    # we want to listen on
    sed -i "s/(^)agentaddress.*/\agentaddress $SNMPD_LISTEN_ADDRESS/" $SNMPD_CONFIG

    # Set system location and contact
    sed -i "s/(^)sysLocation.*/\sysLocation $SYS_LOCATION/" $SNMPD_CONFIG
    sed -i "s/(^)sysContact.*/\sysContact $SYS_CONTACT/" $SNMPD_CONFIG

run_snmpd() {
    if ! command -v snmpd &> /dev/null # check if we have snmpd installed
    then
        install
    fi
    configure
    systemctl restart snmpd
}

uninstall_snmpd() {
    systemctl disable --now snmpd
    apt remove -y snmpd
}


