#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================
#1. Modify default IP
#sed -i 's/192.168.1.1/192.168.5.1/g' openwrt/package/base-files/files/bin/config_generate

#2. Clear the login password
#sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

#3. Replace with JerryKuKu’s Argon
#rm openwrt/package/lean/luci-theme-argon -rf

# Modify default IP
#sed -i 's/192.168.1.1/192.168.1.254/g' package/base-files/files/bin/config_generate
sed -i '/exit 0/i\uci set network.lan.ipaddr='192.168.1.254'\nuci set network.lan.proto='static'\nuci set network.lan.type='bridge'\nuci set network.lan.ifname='eth0'\nuci set network.lan.netmask='255.255.255.0'\nuci set network.lan.gateway='192.168.1.1'\nuci set network.lan.dns='192.168.1.1'\nuci commit network\n ' package/lean/default-settings/files/zzz-default-settings

# Modify default passwork:00000000
sed -i 's!$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.!root:$1$/YSxcdBO$bFuXE13KnaJb25YA8b6/1/:18825:0:99999:7:::!g' openwrt/package/lean/default-settings/files/zzz-default-settings
#sed -i -e 's!root::0:0:99999:7:::!root:$1$/YSxcdBO$bFuXE13KnaJb25YA8b6/1/:18825:0:99999:7:::!g' package/base-files/files/etc/shadow

# Download luci-app-Poweroff
git clone https://github.com/esirplayground/luci-app-poweroff.git package/lean/uci-app-poweroff

# Download OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter.git package/lean/OpenAppFilter

# Change kernel
#sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.4/g' target/linux/x86/Makefile

# Frpc site
sed -i "s/option enabled '0'/option enabled '1'/g" package/lean/luci-app-frpc/root/etc/config/frp
sed -i 's/yourdomain.com/ol301a.venseco.cf/g' package/lean/luci-app-frpc/root/etc/config/frp
sed -i 's/1234567/qazwsx939/g' package/lean/luci-app-frpc/root/etc/config/frp
echo "config proxy
     option enable '1'
     option type 'http'
     option domain_type 'custom_domains'
     option custom_domains 'lede100.venseco.tk'
     option local_ip '192.168.1.254'
     option local_port '80'
     option proxy_protocol_version 'disable'
     option use_encryption '1'
     option use_compression '1'
     option remark 'openwrt'" >> package/lean/luci-app-frpc/root/etc/config/frp
