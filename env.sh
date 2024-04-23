# CONFIGURATION

# System configuration

SYS_LOCATION="Unknown"
SYS_CONTACT="Root <root@$(hostname)>"

INTERFACE=${INTERFACE:=br0} # br0 is LAN. Use brX where X is VLAN ID for other interfaces

ON_BOOT_PRIORITY=${ON_BOOT_PRIORITY:=99}
# END CONFIGURATION

# DO NOT MODIFY BELOW THIS LINE UNLESS YOU ARE SURE OF WHAT YOU ARE DOING

DATA_PATH=/data
ON_BOOT_PATH=/data/on_boot.d
IP_ADDRESS=$(ip -f inet addr show $INTERFACE | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
