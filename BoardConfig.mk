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
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
USE_CAMERA_STUB := true

# Inherit from the proprietary version
-include vendor/htc/passion/BoardConfigVendor.mk

TARGET_BOOTLOADER_BOARD_NAME := mahimahi
TARGET_NO_BOOTLOADER := true

# QSD8250
TARGET_BOARD_PLATFORM := qsd8k
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi

# Neon stuff
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true

# FPU compilation flags
TARGET_GLOBAL_CFLAGS    += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS  += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp

TARGET_SPECIFIC_HEADER_PATH := device/htc/passion/include

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WLAN_DEVICE           := bcm4329
WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/bcm4329.ko"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcm4329.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcm4329_apsta.bin"
WIFI_DRIVER_MODULE_ARG      := "firmware_path=/vendor/firmware/fw_bcm4329.bin nvram_path=/proc/calibration"
WIFI_DRIVER_MODULE_NAME     := "bcm4329"

BOARD_USES_GENERIC_AUDIO := false

# Kernel
BOARD_KERNEL_CMDLINE    := no_console_suspend=1 wire.search_count=5
#console=ttyMSM0,115200n8
BOARD_KERNEL_BASE       := 0x20000000
BOARD_KERNEL_NEW_PPPOX  := true
TARGET_PREBUILT_KERNEL  := device/htc/passion/prebuilt/kernel

# Compass/Accererometer
BOARD_VENDOR_USE_AKMD := akm8973

# Hardware rendering
BOARD_EGL_CFG           := device/htc/passion/egl.cfg
USE_OPENGL_RENDERER     := true
TARGET_USES_GENLOCK     := true
# Unnecessary with new egl libs
#COMMON_GLOBAL_CFLAGS    += -DMISSING_EGL_EXTERNAL_IMAGE
# Our copybit supports YV12 conversion, so not needed
#COMMON_GLOBAL_CFLAGS    += -DMISSING_EGL_PIXEL_FORMAT_YV12
# This just breaks everything
#COMMON_GLOBAL_CFLAGS    += -DFORCE_EGL_CONFIG=0x9 #0x5e5
# We only have 2 buffers so still need to hack it.
COMMON_GLOBAL_CFLAGS    += -DMISSING_GRALLOC_BUFFERS
# Just a safety measure to make sure its all included
COMMON_GLOBAL_CFLAGS    += -DQCOM_HARDWARE
# Force refresh rate since fps calc is broke and reports 0
COMMON_GLOBAL_CFLAGS    += -DREFRESH_RATE=60
# qsd8k: no support for overlay, bypass, or c2d
TARGET_USE_OVERLAY      := false
TARGET_HAVE_BYPASS      := false
TARGET_USES_C2D_COMPOSITION := false

# Try to use ASHMEM if possible (when non-MDP composition is used)
# if enabled, set debug.sf.hw=1 in system.prop
#TARGET_GRALLOC_USES_ASHMEM := true

# Debuging egl
COMMON_GLOBAL_CFLAGS += -DEGL_TRACE

# Find out what these do..if anything
# used in cafs tree nothing actually present is ours (yet)
#HAVE_ADRENO200_SOURCE := true
#HAVE_ADRENO200_SC_SOURCE := true
#HAVE_ADRENO200_FIRMWARE := true
#BOARD_USES_QCNE := true
# I dont think these do anything but everyone else is using them
#BOARD_USE_QCOM_PMEM := true
#BOARD_USES_ADRENO_200 := true
#TARGET_HARDWARE_3D := false

# Qcom
BOARD_VENDOR_QCOM_AMSS_VERSION := 3200
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QCOM_LIBS := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

# FM
BOARD_HAVE_FM_RADIO := true
BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO

# GPS HAL and AMSS version
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := mahimahi
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 3200

# RIL
BOARD_USE_NEW_LIBRIL_HTC := true

# Misc
BOARD_USE_OPENSSL_ENGINE := true

# Hacks
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/usb_mass_storage/lun0/file
BOARD_USE_LEGACY_TRACKPAD       := true
TARGET_FORCE_CPU_UPLOAD         := true

# cat /proc/mtd #AOSP                   # cat /proc/mtd #CM7
# dev:    size   erasesize  name        # dev:    size   erasesize  name
# mtd0: 000e0000 00020000 "misc"        # mtd0: 000e0000 00020000 "misc"
# mtd1: 00500000 00020000 "recovery"    # mtd1: 00400000 00020000 "recovery"
# mtd2: 00280000 00020000 "boot"        # mtd2: 00380000 00020000 "boot"
# mtd3: 07800000 00020000 "system"      # mtd3: 09100000 00020000 "system"
# mtd4: 07800000 00020000 "cache"       # mtd4: 05f00000 00020000 "cache"
# mtd5: 0c440000 00020000 "userdata"    # mtd5: 0c440000 00020000 "userdata"
# mtd6: 00200000 00020000 "crashdata"
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00300000 #0x00380000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00400000

ifeq ($(MINISKIRT),true)
# Less fonts saves ~2mb
SMALLER_FONT_FOOTPRINT := true
# Less sounds (ringtones/notifications)
MINIMAL_NEWWAVELABS := true
# Stock hboot has smaller system partition
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 150994944 #0x09000000 #0x08400000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 205783040 #0x0c440000
else
# Use larger system partiton
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 230686720
BOARD_USERDATAIMAGE_PARTITION_SIZE := 209715200
endif

BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_RELEASETOOLS_EXTENSIONS := device/htc/common
