export FW_DEVICE_IP=192.168.1.7

include theos/makefiles/common.mk

LIBRARY_NAME = Addon
Addon_PROJECT_NAME = BeeSafari
Addon_FILES = BeeSafari.m
Addon_FRAMEWORKS = UIKit Foundation CoreFoundation
Addon_INSTALL_PATH = /Library/Application Support/BeeKeyboard/Addons/$(Addon_PROJECT_NAME).bundle/
Addon_CFLAGS = -DADDON_NAME=\"$(Addon_PROJECT_NAME)\"
Addon_LDFLAGS = -L./forSafari -lforSafari

ADDITIONAL_CFLAGS = -std=c99

include $(THEOS_MAKE_PATH)/library.mk

after-stage::
	$(ECHO_NOTHING)cp -R Resources/* "$(THEOS_STAGING_DIR)$(Addon_INSTALL_PATH)"$(ECHO_END)

ri:: remoteinstall
remoteinstall:: all refreshsettings internal-remoteinstall after-remoteinstall
internal-remoteinstall::
	scp "$(FW_PROJECT_DIR)/obj/Addon.dylib" root@$(FW_DEVICE_IP):"\"$(Addon_INSTALL_PATH)\""
	scp "$(FW_PROJECT_DIR)/Resources/info.plist" root@$(FW_DEVICE_IP):"\"$(Addon_INSTALL_PATH)\""
after-remoteinstall::
	ssh root@$(FW_DEVICE_IP) "killall -9 SpringBoard"

rs:: refreshsettings
refreshsettings::
	scp "$(FW_PROJECT_DIR)/Resources/app.plist" root@$(FW_DEVICE_IP):"\"$(Addon_INSTALL_PATH)\""
	scp -r "$(FW_PROJECT_DIR)/Resources/en.lproj" root@$(FW_DEVICE_IP):"\"$(Addon_INSTALL_PATH)\""
	scp -r "$(FW_PROJECT_DIR)/Resources/ko.lproj" root@$(FW_DEVICE_IP):"\"$(Addon_INSTALL_PATH)\""

