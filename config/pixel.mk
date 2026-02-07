# GMS
WITH_GMS ?= true
ifneq ($(WITH_GMS),false)
$(call inherit-product, vendor/gms/products/gms.mk)
endif

# Google Sans
$(call inherit-product, vendor/cherta/config/gsans.mk)

# Sounds
$(call inherit-product, vendor/cherta/config/sounds.mk)
