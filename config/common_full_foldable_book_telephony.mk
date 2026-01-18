# Inherit mobile common CHerta stuff
$(call inherit-product, vendor/cherta/config/common_mobile.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# Inherit tablet common CHerta stuff
$(call inherit-product, vendor/cherta/config/tablet.mk)

$(call inherit-product, vendor/cherta/config/telephony.mk)

PRODUCT_PACKAGE_OVERLAYS += vendor/cherta/overlay/foldable_book
