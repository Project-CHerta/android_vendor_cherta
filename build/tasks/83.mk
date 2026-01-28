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

CHERTA_TARGET_PACKAGE := $(PRODUCT_OUT)/CHerta_$(CHERTA_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

$(CHERTA_TARGET_PACKAGE): $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CHERTA_TARGET_PACKAGE)
	$(hide) $(SHA256) $(CHERTA_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CHERTA_TARGET_PACKAGE).sha256sum
	@echo -e "=======================-Welcome to ${CL_MAG}Herta Space Station${CL_RST}!-======================"
	@echo -e ${CL_BLU}"                                                                              "${CL_BLU}
	@echo -e ${CL_CYN}"I hope you enjoy your stay here. ^^"${CL_RST}
	@echo -e ${CL_BLU}"                                                                              "${CL_BLU}
	@echo -e ${CL_CYN}"=============================-OTA Package Details-============================"${CL_RST}
	@echo -e ${CL_CYN}"Output ZIP     : "${CL_MAG} $(CHERTA_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_CYN}"SHA256		  : "${CL_MAG}" $(shell cat $(CHERTA_TARGET_PACKAGE).sha256sum | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size           : "${CL_MAG}" $(shell du -hs $(CHERTA_TARGET_PACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"==========================================================================="${CL_RST}
	@echo -e ""

.PHONY: 83
83: $(CHERTA_TARGET_PACKAGE) $(DEFAULT_GOAL)
