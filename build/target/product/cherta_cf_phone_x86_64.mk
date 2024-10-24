# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64/phone/aosp_cf.mk)

include vendor/cherta/build/target/product/cherta_generic_target.mk

TARGET_NO_KERNEL_OVERRIDE := true
WITH_GMS := false

# Overrides
PRODUCT_NAME := cherta_cf_phone_x86_64
PRODUCT_MODEL := CHerta Cuttlefish phone built for x86_64
