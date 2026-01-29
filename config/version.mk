CHERTA_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M%S)

CHERTA_BUILD_VERSION := 25H2
CHERTA_VERSION := $(CHERTA_BUILD_VERSION)-$(CHERTA_BUILD)-$(CHERTA_BUILD_DATE)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.cherta.build.date=$(CHERTA_BUILD_DATE) \
    ro.cherta.device=$(CHERTA_BUILD) \
    ro.cherta.version=$(CHERTA_VERSION)
