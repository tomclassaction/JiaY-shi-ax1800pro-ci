#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default IP
sed -i 's/192.168.1.1/192.168.123.23/g' package/base-files/files/bin/config_generate

# 默认开启 wifi
# sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh


mkdir -p files/etc/config


tee files/etc/config/wireless <<EOF

config wifi-device 'radio0'
	option type 'mac80211'
	option path 'platform/soc@0/c000000.wifi'
	option channel '36'
	option band '5g'
	option htmode 'HE80'
	option cell_density '0'

config wifi-iface 'default_radio0'
	option device 'radio0'
	option network 'lan'
	option mode 'ap'
	option ssid 'jdc-5g'
	option encryption 'sae-mixed'
	option key '1234567890'

config wifi-device 'radio1'
	option type 'mac80211'
	option path 'platform/soc@0/c000000.wifi+1'
	option channel '1'
	option band '2g'
	option htmode 'HE20'
	option disabled '1'

config wifi-iface 'default_radio1'
	option device 'radio1'
	option network 'lan'
	option mode 'ap'
	option ssid 'OpenWrt'
	option encryption 'none'

EOF


