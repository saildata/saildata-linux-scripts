#!/usr/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Display CPU/GPU/Display/Wifi stats as vitals check

green=$(tput setaf 2)
blue=$(tput setaf 4)
aqua=$(tput setaf 6)
purple=$(tput setaf 5)
normal=$(tput sgr0)

function get_gpu_stats() {
    _GPU_FREQ1=$(nvidia-smi --query-gpu=clocks.gr --format=csv,noheader)
    _GPU_FREQ2=$(nvidia-smi --query-gpu=clocks.sm --format=csv,noheader)
    _GPU_FREQ3=$(nvidia-smi --query-gpu=clocks.mem --format=csv,noheader)
    _GPU_FREQ4=$(nvidia-smi --query-gpu=clocks.video --format=csv,noheader)

    printf "\n%s\n\n" "${green}||---GPU-CORE-TEMP-----||---GPU-FREQUENCIES,-----------------------------||"

    _GPU_TEMP=$(nvidia-smi -q | grep -i "GPU Current Temp")

    printf "%s\t%s" "$_GPU_TEMP" "GRAPHICS: $_GPU_FREQ1" | tr -s "[:space:]"
    printf "\n%s" "                                  SM: $_GPU_FREQ2"
    printf "\n%s" "                              MEMORY: $_GPU_FREQ3"
    printf "\n%s" "                               VIDEO: $_GPU_FREQ3"
    printf "\n%s" "                               VIDEO: $_GPU_FREQ4"
    echo -e "\n${normal}"
}

function get_cpu_stats() {
    _CPU_TEMP1=$( cat /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input )
    _CPU_TEMP2=$( cat /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp2_input )
    _CPU_TEMP3=$( cat /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp3_input )
    _CPU_TEMP4=$( cat /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp4_input )
    _CPU_TEMP5=$( cat /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp5_input )
    _CPU_FREQ1=$( cat /proc/cpuinfo | grep -i mhz | sed -n '1,1p' | awk '{print $4 Mhz}' )
    _CPU_FREQ2=$( cat /proc/cpuinfo | grep -i mhz | sed -n '2,2p' | awk '{print $4 Mhz}' )
    _CPU_FREQ3=$( cat /proc/cpuinfo | grep -i mhz | sed -n '3,3p' | awk '{print $4 Mhz}' )
    _CPU_FREQ4=$( cat /proc/cpuinfo | grep -i mhz | sed -n '4,4p' | awk '{print $4 Mhz}' )
    _CPU_FREQ5=$( cat /proc/cpuinfo | grep -i mhz | sed -n '5,5p' | awk '{print $4 Mhz}' )
    _CPU_FREQ6=$( cat /proc/cpuinfo | grep -i mhz | sed -n '6,6p' | awk '{print $4 Mhz}' )
    _CPU_FREQ7=$( cat /proc/cpuinfo | grep -i mhz | sed -n '7,7p' | awk '{print $4 Mhz}' )
    _CPU_FREQ8=$( cat /proc/cpuinfo | grep -i mhz | sed -n '8,8p' | awk '{print $4 Mhz}' )

    printf "%s\n\n" "${aqua}||---CPU-PHYS-TEMP----||---CPU-FREQUENCIES (LOGICAL)--------------------||"
    printf "%0.10s"           "MAIN  : ""$_CPU_TEMP1 """
    printf "\n%.10s\t%s"     "PCORE1: "$_CPU_TEMP2 "            L1: "$_CPU_FREQ1" MHz    L2: "$_CPU_FREQ2" MHz"
    printf "\n%.10s\t%s"     "PCORE2: "$_CPU_TEMP3 "            L3: "$_CPU_FREQ3" MHz    L4: "$_CPU_FREQ4" MHz"
    printf "\n%.10s\t%s"     "PCORE3: "$_CPU_TEMP4 "            L5: "$_CPU_FREQ5" MHz    L6: "$_CPU_FREQ6" MHz"
    printf "\n%.10s\t%s"     "PCORE4: "$_CPU_TEMP5 "            L7: "$_CPU_FREQ7" MHz    L8: "$_CPU_FREQ8" MHz"
    echo -e "\n${normal}" | tr -s "[:space:]"
}

function get_inet_info(){
    printf "%s\n\n" "${blue}||---INET-INFO-------||-------------------------------------------------||"

    _INET=$( ifconfig | grep enp4s0 --after-context=6 --color=never )
    echo "$_INET" | tr -s "[:space:]" | sed -n 2,2p | cut -d ' ' -f 1-3
    echo -e "${normal}" | tr -s "[:space:]"

}

function get_misc(){
    printf "%s\n" "${purple}||---MISC------------||------------------------------------------------||"

    _RESOLUTION=$( xdpyinfo | grep -B 1 dimensions | cut -d':' -f2- | tail -1)
    _KBD_RPT=$(xset -q | egrep -o 'auto repeat delay:.*')
    printf "%s"            "$_RESOLUTION" | awk '{ print $1,$2,$3,$4}'
    printf " %s\t\n"          "$_KBD_RPT" | tr -s "[:space:]"
    echo -e "${normal}" | tr -s "[:space:]"
}

function get_arch_db_info(){
    printf "%s\n\n" "${green}||---ARCH DB--------||-------------------------------------------------||"

    _DB_STATUS_COL1=$( ls -lA /var/lib/pacman/sync/*.db | sed -n '1,1p' | awk '{ print $6,$7,$8,$9 }' )
    _DB_STATUS_COL2=$( ls -lA /var/lib/pacman/sync/*.db | sed -n '2,2p' | awk '{ print $6,$7,$8,$9 }' )
    _DB_STATUS_COL3=$( ls -lA /var/lib/pacman/sync/*.db | sed -n '3,3p' | awk '{ print $6,$7,$8,$9 }' )
    _DB_STATUS_COL4=$( ls -lA /var/lib/pacman/sync/*.db | sed -n '4,4p' | awk '{ print $6,$7,$8,$9 }' )
    _DB_STATUS_COL5=$( ls -lA /var/lib/pacman/sync/*.db | sed -n '5,5p' | awk '{ print $6,$7,$8,$9 }' )
    _DB_STATUS_COL6=$( ls -lA /var/lib/pacman/sync/*.db | sed -n '6,6p' | awk '{ print $6,$7,$8,$9 }' )


    printf "%s\t%s\n" "$_DB_STATUS_COL1" "$_DB_STATUS_COL4" | tr -s "[:space:]"
    printf "%s\t%s\n" "$_DB_STATUS_COL2" "$_DB_STATUS_COL5" | tr -s "[:space:]"
    printf "%s\t%s\n" "$_DB_STATUS_COL3" "$_DB_STATUS_COL6" | tr -s "[:space:]"

    echo -e "\n${normal}" | tr -s "[:space:]"
}

get_gpu_stats; get_cpu_stats; get_inet_info; get_misc; get_arch_db_info