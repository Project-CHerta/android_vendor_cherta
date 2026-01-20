# Inherit mobile full common CHerta stuff
$(call inherit-product, vendor/cherta/config/common_mobile_full.mk)

# Don't ship cellular stuff
WITH_GMS_COMMS_SUITE := false

# Inherit tablet common CHerta stuff
$(call inherit-product, vendor/cherta/config/tablet.mk)

$(call inherit-product, vendor/cherta/config/wifionly.mk)
