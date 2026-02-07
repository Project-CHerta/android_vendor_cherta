CHERTA_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M%S)

ifeq ($(WITH_GMS),false)
CHERTA_BUILDTYPE := Vanilla
else
CHERTA_BUILD_TYPE := Pixel
endif

CHERTA_BUILD_VERSION := 25H2
CHERTA_VERSION := $(CHERTA_BUILD_VERSION)-$(CHERTA_BUILDTYPE)-$(CHERTA_BUILD)-$(CHERTA_BUILD_DATE)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.cherta.build.date=$(CHERTA_BUILD_DATE) \
    ro.cherta.device=$(CHERTA_BUILD) \
    ro.cherta.version=$(CHERTA_VERSION)
