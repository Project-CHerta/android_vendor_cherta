# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# CHerta OTA update package

CHERTA_TARGET_OTAPACKAGE := $(PRODUCT_OUT)/CHerta_$(CHERTA_VERSION).zip
CHERTA_TARGET_UPDATEPACKAGE := $(PRODUCT_OUT)/CHerta_$(CHERTA_VERSION)-img.zip

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: cherta
cherta: $(DEFAULT_GOAL) $(INTERNAL_OTA_PACKAGE_TARGET) $(INTERNAL_UPDATE_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CHERTA_TARGET_OTAPACKAGE)
	$(hide) $(MD5) $(CHERTA_TARGET_OTAPACKAGE) > $(CHERTA_TARGET_OTAPACKAGE).md5sum
	$(hide) ln -f $(INTERNAL_UPDATE_PACKAGE_TARGET) $(CHERTA_TARGET_UPDATEPACKAGE)
	$(hide) $(MD5) $(MICA_TARGET_UPDATEPACKAGE) > $(CHERTA_TARGET_UPDATEPACKAGE).md5sum
	@echo -e ""
	@echo -e ${CL_CYN}"=============================-Build Completed-============================="${CL_RST}
	@echo -e ${CL_BLU}"                                                                              "${CL_BLU}
	@echo -e ${CL_CYN}"Thanks for spending time with CHerta!"${CL_RST}
	@echo -e ${CL_BLU}"                                                                              "${CL_BLU}
	@echo -e ${CL_CYN}"===========================-OTA Package Details-==========================="${CL_RST}
	@echo -e ${CL_CYN}"Output ZIP  : "${CL_MAG} $(CHERTA_TARGET_OTAPACKAGE)${CL_RST}
	@echo -e ${CL_CYN}"MD5         : "${CL_MAG}" $(shell cat $(CHERTA_TARGET_OTAPACKAGE).md5sum | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size        : "${CL_MAG}" $(shell du -hs $(CHERTA_TARGET_OTAPACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"==========================================================================="${CL_RST}
	@echo -e ""
	@echo -e ${CL_CYN}"=========================-Fastboot Package Details-========================"${CL_RST}
	@echo -e ${CL_CYN}"Output ZIP  : "${CL_MAG} $(CHERTA_TARGET_UPDATEPACKAGE)${CL_RST}
	@echo -e ${CL_CYN}"MD5         : "${CL_MAG}" $(shell cat $(CHERTA_TARGET_UPDATEPACKAGE).md5sum | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size        : "${CL_MAG}" $(shell du -hs $(CHERTA_TARGET_UPDATEPACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"==========================================================================="${CL_RST}
	@echo -e ""
