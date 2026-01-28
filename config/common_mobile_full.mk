# Inherit common CHerta stuff
$(call inherit-product, vendor/cherta/config/common_mobile.mk)

PRODUCT_SIZE := full

# PDF viewer
PRODUCT_PACKAGES += \
    Camelot

ifneq ($(PRODUCT_NO_CAMERA),true)
PRODUCT_PACKAGES += \
    Aperture
endif

