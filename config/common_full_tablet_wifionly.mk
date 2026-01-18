# Inherit mobile common CHerta stuff
$(call inherit-product, vendor/cherta/config/common_mobile.mk)

# Inherit tablet common CHerta stuff
$(call inherit-product, vendor/cherta/config/tablet.mk)

$(call inherit-product, vendor/cherta/config/wifionly.mk)
