create_qsdk_base()
{

    rm -rf BOOT.AK.1.0 BOOT.BF.3.1.1 IPQ4019.ILQ.11.* IPQ8064.ILQ.11.* RPM.AK.* TZ.AK.* TZ.BF.2.7 WIGIG.TLN* IPQ6018.ILQ.11.* TZ.WNS.5.1 BOOT.XF.0.3 BOOT.BF.3.3.1.1 TZ.WNS.4.0 IPQ5018.ILQ.11.* BTFW.MAPLE.*

    cp -rf BOOT.BF.3.3.1/* .
    cp -rf CNSS.PS.3.16/* .
    cp -rf IPQ8074.ILQ.11.5/* .
    cp -rf NHSS.QSDK.11.5/* .
    cp -rf NSS.FW.11.5/* .
    cp -rf RPM.BF.2.4.1/* .
    cp -rf TZ.BF.4.0.8/* .
    cp -rf WLAN.BL.3.16/* .
    cp -rf WLAN.HK.2.6/* .

    mkdir -p qsdk/dl
    cp -rf apss_proc/out/proprietary/Wifi/qsdk-ieee1905-security/* qsdk
    cp -rf apss_proc/out/proprietary/Wifi/qsdk-qca-art/* qsdk
    cp -rf apss_proc/out/proprietary/Wifi/qsdk-qca-wifi/* qsdk
    cp -rf apss_proc/out/proprietary/Wifi/qsdk-qca-wlan/* qsdk
    cp -rf wlan_proc/src/components/QCA8074_v2.0/qca-wifi-fw-src-component-cmn-WLAN.HK.* qsdk/dl/
    cp -rf wlan_proc/pkg/wlan_proc/bin/QCA8074_v1.0/qca-wifi-fw-QCA8074_v1.0-WLAN.HK.*.tar.bz2 qsdk/dl/
    cp -rf wlan_proc/pkg/wlan_proc/bin/QCA8074_v2.0/qca-wifi-fw-QCA8074_v2.0-WLAN.HK.*.tar.bz2 qsdk/dl/
    tar xvf cnss_proc/src/components/qca-wifi-fw-src-component-cmn-WLAN.BL.*.tgz -C qsdk/dl
    tar xvf cnss_proc/src/components/qca-wifi-fw-src-component-halphy_tools-WLAN.BL.*.tgz -C qsdk/dl
    cp -rf cnss_proc/src/components/* qsdk/dl
    cp -rf cnss_proc/bin/QCA9888/hw.2/* qsdk/dl
    cp -rf cnss_proc/bin/AR900B/hw.2/* qsdk/dl
    cp -rf cnss_proc/bin/QCA9984/hw.1/* qsdk/dl
    cp -rf cnss_proc/bin/IPQ4019/hw.1/* qsdk/dl
    cp -rf qca-wifi-fw-AR988* qsdk/dl
    cp -rf apss_proc/out/proprietary/QSDK-Base/meta-tools/ .
    cp -rf apss_proc/out/proprietary/QSDK-Base/common-tools/* qsdk/
    cp -rf apss_proc/out/proprietary/QSDK-Base/qsdk-qca-nss/* qsdk/
    cp -rf apss_proc/out/proprietary/QSDK-Base/qca-lib/* qsdk/
    cp -rf apss_proc/out/proprietary/BLUETOPIA/qca-bluetopia/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/qca-mcs-apps/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/qca-nss-userspace/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/qca-time-services/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/qca-qmi-framework/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/gpio-debug/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/qca-diag/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/qca-cnss-daemon/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/athtestcmd/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/fw-qca-stats/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/btdaemon/* qsdk
    cp -rf apss_proc/out/proprietary/QSDK-Base/minidump/* qsdk
    tar xjvf apss_proc/out/proprietary/QSDK-Base/qca-IOT/qca-IOT.tar.bz2 -C qsdk
    sed -i '/QCAHKSWPL_SILICONZ/c\PKG_VERSION:=WLAN.HK.2.6-02451-QCAHKSWPL_SILICONZ-1' qsdk/qca/feeds/qca_hk/net/qca-hk/Makefile
    cp apss_proc/out/proprietary/QSDK-Base/qca-nss-fw-eip-hk/BIN-EIP*.HK.* qsdk/dl/
    cp nss_proc/out/proprietary/* qsdk/dl
    cp -rf apss_proc/out/proprietary/RBIN-AFCAgent/qca-afc-bin/* qsdk

    echo "$1 $2"
    if [ $1 -eq 32 ]; then
        mkdir -p qsdk/staging_dir/target-arm_cortex-a7_musl-1.1.16_eabi/usr/lib/
        cd qsdk/prebuilt/ipq807x/ipq_premium
        tar zxpvf qti-mfg-provision_1.0-1_ipq.ipk
        tar zxpvf data.tar.gz
        cp -rf ./usr/lib/libprovision.so ../../../staging_dir/target-arm_cortex-a7_musl-1.1.16_eabi/usr/lib/
        cd $2
        mkdir -p qsdk/staging_dir/target-arm_cortex-a7_musl-1.1.16_eabi/pkginfo/
        touch qsdk/staging_dir/target-arm_cortex-a7_musl-1.1.16_eabi/pkginfo/qti-mfg-provision.provides
        echo libprovision.so > qsdk/staging_dir/target-arm_cortex-a7_musl-1.1.16_eabi/pkginfo/qti-mfg-provision.provides

    elif [ $1 -eq 64 ]; then
        mkdir -p qsdk/staging_dir/target-aarch64_cortex-a53_musl-1.1.16/usr/lib/
        cd qsdk/prebuilt/ipq807x_64/ipq_premium
        tar zxpvf qti-mfg-provision_1.0-1_ipq.ipk
        tar zxpvf data.tar.gz
        cp -rf ./usr/lib/libprovision.so ../../../staging_dir/target-aarch64_cortex-a53_musl-1.1.16/usr/lib/
        cd $2
        mkdir -p qsdk/staging_dir/target-aarch64_cortex-a53_musl-1.1.16/pkginfo/
        touch qsdk/staging_dir/target-aarch64_cortex-a53_musl-1.1.16/pkginfo/qti-mfg-provision.provides
        echo libprovision.so > qsdk/staging_dir/target-aarch64_cortex-a53_musl-1.1.16/pkginfo/qti-mfg-provision.provides
	fi

	cd qsdk/
   	./scripts/feeds update -a
   	./scripts/feeds install -a -f
}

case $1 in
    32)
        create_qsdk_base $1 $(pwd -P) #Copy codes to generate code base
        cp qca/configs/qsdk/ipq_premium.config .config
        sed -i "s/TARGET_ipq_ipq806x/TARGET_ipq_ipq807x/g" .config
        mv prebuilt/ipq807x/ipq_premium/* prebuilt/ipq807x/
    ;;
    64)
        create_qsdk_base $1 $(pwd -P) #Copy codes to generate code base
        cp qca/configs/qsdk/ipq_premium.config .config
        sed -i "s/TARGET_ipq_ipq806x/TARGET_ipq_ipq807x_64/g" .config
        mv prebuilt/ipq807x_64/ipq_premium/* prebuilt/ipq807x_64/
    ;;
    *)
        echo ""
        echo "Provide correct image version to be built"
        echo "Syntax: ./configure_hawkeye.sh [32/64]"
        echo ""
        exit
    ;;

esac    

make defconfig
sed -i -e "/CONFIG_PACKAGE_qca-wifi-fw-hw5-10.4-asic/d" .config
sed -i -e "s/# CONFIG_DRIVER_WEXT_SUPPORT is not set/CONFIG_DRIVER_WEXT_SUPPORT=y/g" .config

sed -i -e "s/CONFIG_BUSYBOX_CONFIG_IP=y/# CONFIG_BUSYBOX_CONFIG_IP is not set/g" .config
sed -i -e "/CONFIG_BUSYBOX_CONFIG_FEATURE_IP_ADDRESS=y/d" .config
sed -i -e "/CONFIG_BUSYBOX_CONFIG_FEATURE_IP_LINK=y/d" .config
sed -i -e "/CONFIG_BUSYBOX_CONFIG_FEATURE_IP_ROUTE=y/d" .config
sed -i -e "/CONFIG_BUSYBOX_CONFIG_FEATURE_IP_ROUTE_DIR/d" .config
sed -i -e "/# CONFIG_BUSYBOX_CONFIG_FEATURE_IP_TUNNEL is not set/d" .config
sed -i -e "/CONFIG_BUSYBOX_CONFIG_FEATURE_IP_RULE=y/d" .config
sed -i -e "/CONFIG_BUSYBOX_CONFIG_FEATURE_IP_NEIGH=y/d" .config
sed -i -e "/# CONFIG_BUSYBOX_CONFIG_FEATURE_IP_RARE_PROTOCOLS is not set/d" .config
sed -i -e "s/# CONFIG_BUSYBOX_CONFIG_KLOGD is not set/CONFIG_BUSYBOX_CONFIG_KLOGD=y/g" .config
sed -i -e "s/# CONFIG_BUSYBOX_CONFIG_LOGREAD is not set/CONFIG_BUSYBOX_CONFIG_LOGREAD=y/g" .config
sed -i -e "s/# CONFIG_BUSYBOX_CONFIG_SYSLOGD is not set/CONFIG_BUSYBOX_CONFIG_SYSLOGD=y/g" .config
sed -i "$ a CONFIG_BUSYBOX_CONFIG_FEATURE_SYSLOGD_READ_BUFFER_SIZE=256" .config
sed -i "$ a CONFIG_BUSYBOX_CONFIG_FEATURE_KMSG_SYSLOG=y" .config
sed -i "$ a CONFIG_BUSYBOX_CONFIG_FEATURE_SYSLOGD_CFG=y" .config
sed -i "$ a CONFIG_BUSYBOX_CONFIG_FEATURE_ROTATE_LOGFILE=y" .config
sed -i -e "s/CONFIG_PACKAGE_curl=m/CONFIG_PACKAGE_curl=y/g" .config
sed -i -e "s/CONFIG_PACKAGE_libcurl=m/CONFIG_PACKAGE_libcurl=y/g" .config
sed -i -e "s/CONFIG_PACKAGE_iperf3=m/CONFIG_PACKAGE_iperf3=y/g" .config
sed -i 's/\$(DRIVER_PATH)\/component_dev\/tools\/linux\/cfg80211_ven_cmd.h/\$(PKG_BUILD_DIR)\/component_dev\/tools\/linux\/cfg80211_ven_cmd.h/g' package/feeds/qca/qca-wifi/Makefile

echo "src-link opensync ../qca/feeds/opensync" >> feeds.conf
./scripts/feeds update -a 
./scripts/feeds install -a -f
