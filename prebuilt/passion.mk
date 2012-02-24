#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

# Overlay files / Locale
DEVICE_PACKAGE_OVERLAYS := device/htc/passion/overlay
PRODUCT_LOCALES := en

# General propreties
PRODUCT_PROPERTY_OVERRIDES := \
    ro.sf.lcd_density=240 \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=180 \
    ro.media.dec.jpeg.memcap=20000000 \
    ro.opengles.version=131072 \
    dalvik.vm.heapsize=64m

# Ril properties
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libhtc_ril.so \
    ro.ril.enable.managed.roaming=1 \
    ro.ril.oem.nosim.ecclist=911,112,999,000,08,118,120,122,110,119,995 \
    ro.ril.emc.mode=2 \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=10

#    ro.ril.hsdpa.category=8 \
#    ro.ril.hsupa.category=5 \
#    ro.ril.gprsclass=12

# Default network type.
# 0 => /* GSM/WCDMA (WCDMA preferred) */
# 3 => /* GSM/WCDMA (auto mode, according to PRL) */
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.default_network=3

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Ril workaround
ADDITIONAL_BUILD_PROPERTIES += ro.telephony.ril.v3=signalstrength
    #,skipbrokendatacall,facilitylock,datacall,icccardstatus

# Disable HWAccel for now
ADDITIONAL_BUILD_PROPERTIES += ro.config.disable_hw_accel=true

# Set usb type
ADDITIONAL_DEFAULT_PROPERTIES += \
    persist.sys.usb.config=mass_storage \
    persist.service.adb.enable=1 \
    usb_wakeup=enable

# Performance Tweaks
PRODUCT_PROPERTY_OVERRIDES += \
    pm.sleep_mode=1 \
    ro.ril.disable.power.collapse=0 \
    windowsmgr.max_events_per_sec=150 \
    ro.telephony.call_ring.delay=0 \
    ro.lge.proximity.delay=10 \
    mot.proximity.delay=10 \
    Debug.performance.tuning=1 \
    Video.accelerate.hw=1 \
    ro.HOME_APP_ADJ=1 \
    ro.PERCEPTIBLE_APP_ADJ=0 \
    debug.sf.hw=1 \
    persist.adb.notify=0 \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.verify-bytecode=false \
    dalvik.vm.dexopt-flags=v=n,o=v \
    persist.sys.use_dithering=0 \
net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960

#
# Packages needed for Passion
#
# Sensors and stuff
PRODUCT_PACKAGES := \
    com.android.future.usb.accessory \
    gps.mahimahi \
    lights.mahimahi \
    sensors.mahimahi \
    librs_jni
# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.primary.qsd8k \
    audio_policy.qsd8k
# GPU
PRODUCT_PACKAGES += \
    copybit.qsd8k \
    gralloc.qsd8k \
    hwcomposer.default
#    hwcomposer.qsd8k \
#    libgenlock \
#    libmemalloc \
#    libtilerenderer \
#    libQcomUI
# Omx
PRODUCT_PACKAGES += \
    libOmxCore \
    libOmxVidEnc \
    libOmxVdec \
    libstagefrighthw

# Passion uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Prebuilt files/configs
PRODUCT_COPY_FILES := \
    device/htc/passion/init.mahimahi.rc:root/init.mahimahi.rc \
    device/htc/passion/init.mahimahi.usb.rc:root/init.mahimahi.usb.rc \
    device/htc/passion/ueventd.mahimahi.rc:root/ueventd.mahimahi.rc \
    device/htc/passion/mahimahi-keypad.kl:system/usr/keylayout/mahimahi-keypad.kl \
    device/htc/passion/mahimahi-keypad.kcm:system/usr/keychars/mahimahi-keypad.kcm \
    device/htc/passion/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/passion/mahimahi-nav.idc:system/usr/idc/mahimahi-nav.idc \
    device/htc/passion/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
    device/htc/passion/vold.fstab:system/etc/vold.fstab

# Prebuilt Modules
PRODUCT_COPY_FILES += \
    device/htc/passion/prebuilt/bcm4329.ko:system/lib/modules/bcm4329.ko

# Prebuilt Kernel
PRODUCT_COPY_FILES += \
    device/htc/passion/prebuilt/kernel:kernel

# prebuilt camera modules
PRODUCT_COPY_FILES += \
    device/htc/passion/prebuilt/camera.qsd8k.so:system/lib/hw/camera.qsd8k.so \
    device/htc/passion/prebuilt/liboemcamera.so:system/lib/liboemcamera.so \
    device/htc/passion/prebuilt/libcamera.so:system/lib/libcamera.so

PRODUCT_COPY_FILES += \
    device/htc/passion/prebuilt/libOmxCore.so:system/lib/libOmxCore.so \
    device/htc/passion/prebuilt/libOmxVdec.so:system/lib/libOmxVdec.so \
    device/htc/passion/prebuilt/libOmxVidEnc.so:system/lib/libOmxVidEnc.so \
    device/htc/passion/prebuilt/libmediaplayerservice.so:system/lib/libmediaplayerservice.so \
    device/htc/passion/prebuilt/libstagefrighthw.so:system/lib/libstagefrighthw.so

# other stuff
PRODUCT_COPY_FILES += \
    device/htc/passion/prebuilt/libgui.so:system/lib/libgui.so \
    device/htc/passion/prebuilt/libjni_mosaic.so:system/lib/libjni_mosaic.so

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distict.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/passion/media_profiles.xml:system/etc/media_profiles.xml

# Proprietary makefile
$(call inherit-product-if-exists, vendor/htc/passion/passion-vendor.mk)

# media profiles and capabilities spec
$(call inherit-product, device/htc/passion/media_a1026.mk)

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/passion/passion-vendor.mk)
