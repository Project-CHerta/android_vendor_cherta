CHERTA_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M%S)

CHERTA_BUILD_TYPE ?= Homemade
CHERTA_BUILD_VERSION := 25H2
CHERTA_VERSION := $(CHERTA_BUILD_VERSION)-$(CHERTA_BUILD_TYPE)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.cherta.buildtype=$(CHERTA_BUILD_TYPE) \
    ro.cherta.build.date=$(CHERTA_BUILD_DATE) \
    ro.cherta.device=$(CHERTA_BUILD) \
    ro.cherta.version=$(CHERTA_VERSION)
