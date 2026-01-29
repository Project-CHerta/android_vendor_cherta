# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

# Allow vendor prebuilt repos to exclude themselves from bp scanning
-include $(sort $(wildcard vendor/*/*/exclude-bp.mk))

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_EXT_PROPERTIES += ro.adb.secure=0
else
ifdef WITH_ADB_INSECURE
# Forcebly disable ADB authentication
PRODUCT_SYSTEM_EXT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_EXT_PROPERTIES += ro.adb.secure=1

# Set ro.debuggable=0 for userdebug
PRODUCT_NOT_DEBUGGABLE_IN_USERDEBUG := true
endif

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_PRODUCT_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Allow downgrade on user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Credential storage
PRODUCT_PACKAGES += \
    android.software.credentials.prebuilt.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Component overrides
PRODUCT_PACKAGES += \
    cherta-component-overrides.xml

# Enforce privapp-permissions whitelist
PRODUCT_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Enable whole-program R8 Java optimizations for SystemUI and system_server,
# but also allow explicit overriding for testing and development.
SYSTEM_OPTIMIZE_JAVA ?= true
SYSTEMUI_OPTIMIZE_JAVA ?= true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Storage manager
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Root
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    adb_root

ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/xbin/su
endif
endif

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

PRODUCT_PRODUCT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed

ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_PRODUCT_PROPERTIES += \
    debug.sf.enable_transaction_tracing=false
endif

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/cherta/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/cherta/overlay/common \
    vendor/cherta/overlay/no-rro

PRODUCT_PACKAGES += \
    NetworkStackOverlay

# Translations
CUSTOM_LOCALES += \
    ast_ES \
    gd_GB \
    cy_GB \
    fur_IT

-include vendor/lineage-priv/keys/keys.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk

# CHerta stuff go here

# Bootanimation
ifeq ($(strip $(TARGET_BOOT_ANIMATION_RES)),)
    $(warning "TARGET_BOOT_ANIMATION_RES is undefined, assuming 1080p")
else
    $(call soong_config_set,vendor_cherta,bootanimation_res,$(TARGET_BOOT_ANIMATION_RES))
endif

PRODUCT_PACKAGES += \
    bootanimation \
    bootanimation_dark

# GMS
include vendor/cherta/config/pixel.mk

# Versioning
include vendor/cherta/config/version.mk
