# Copyright (C) 2016-2020 DerpFest
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

# Versioning System
ifneq ($(filter eng userdebug,$(TARGET_BUILD_VARIANT)),)
    BUILD_DATE := $(shell date +%Y%m%d-%H%M)
else
    BUILD_DATE := $(shell date +%Y%m%d)
endif

TARGET_PRODUCT_SHORT := $(subst synth_,,$(SYNTH_BUILDTYPE))
DERP_BUILD_VERSION := $(PLATFORM_VERSION)

SYNTH_BUILDTYPE ?= Community
SYNTH_VERSION_PRODUCT := Resonance
SYNTH_VERSION_MODEL := 2.0-Alpha
SYNTH_VERSION := $(SYNTH_VERSION_PRODUCT)-$(SYNTH_VERSION_MODEL)-$(SYNTH_BUILDTYPE)-$(DERP_BUILD)-$(BUILD_DATE)
ROM_FINGERPRINT := Synth/$(SYNTH_VERSION_PRODUCT)/$(SYNTH_VERSION_MODEL)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

ifeq ($(SYNTH_BUILDTYPE), CI)
    BUILD_KEYS := release-keys
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.derp.build.version=$(DERP_BUILD_VERSION) \
  ro.derp.build.date=$(BUILD_DATE) \
  ro.synth.buildtype=$(SYNTH_BUILDTYPE) \
  ro.synth.fingerprint=$(ROM_FINGERPRINT) \
  ro.synth.version.product=$(SYNTH_VERSION_PRODUCT) \
  ro.synth.version.model=$(SYNTH_VERSION_MODEL) \
  ro.synth.version=$(SYNTH_VERSION) \
  ro.derp.device=$(DERP_BUILD) \
  ro.modversion=$(DERP_VERSION)

ifneq ($(OVERRIDE_OTA_CHANNEL),)
    PRODUCT_PROPERTY_OVERRIDES += \
        derp.updater.uri=$(OVERRIDE_OTA_CHANNEL)
endif
