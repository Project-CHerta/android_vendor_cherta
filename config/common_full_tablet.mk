# Inherit mobile full common CHerta stuff
$(call inherit-product, vendor/cherta/config/common_mobile_full.mk)

# Inherit tablet common CHerta stuff
$(call inherit-product, vendor/cherta/config/tablet.mk)

$(call inherit-product, vendor/cherta/config/telephony.mk)
