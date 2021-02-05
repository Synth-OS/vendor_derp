SYNTH_TARGET_PACKAGE := $(PRODUCT_OUT)/Synth-$(SYNTH_VERSION).zip

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: derp bacon
derp: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(SYNTH_TARGET_PACKAGE)
	$(hide) $(MD5) $(SYNTH_TARGET_PACKAGE) | cut -d ' ' -f1 > $(SYNTH_TARGET_PACKAGE).md5sum
	$(hide) ./vendor/derp/tools/generate_json_build_info.sh $(SYNTH_TARGET_PACKAGE)
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}SynthOS ${txtrst}";
	@echo -e ""
	@echo -e ${CL_GRN}"███████╗██╗   ██╗███╗   ██╗████████╗██╗  ██╗     ██████╗ ███████╗"
	@echo -e ${CL_GRN}"██╔════╝╚██╗ ██╔╝████╗  ██║╚══██╔══╝██║  ██║    ██╔═══██╗██╔════╝"
	@echo -e ${CL_GRN}"███████╗ ╚████╔╝ ██╔██╗ ██║   ██║   ███████║    ██║   ██║███████╗"
	@echo -e ${CL_GRN}"╚════██║  ╚██╔╝  ██║╚██╗██║   ██║   ██╔══██║    ██║   ██║╚════██║"
	@echo -e ${CL_GRN}"███████║   ██║   ██║ ╚████║   ██║   ██║  ██║    ╚██████╔╝███████║"
	@echo -e ${CL_GRN}"╚══════╝   ╚═╝   ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝     ╚═════╝ ╚══════╝"
	@echo -e ""
	@echo -e "zip: "$(SYNTH_TARGET_PACKAGE)
	@echo -e "md5: `cat $(SYNTH_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"
	@echo -e "size:`ls -lah $(SYNTH_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: derp
