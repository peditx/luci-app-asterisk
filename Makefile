include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-asterisk
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKGARCH:=all

PKG_DEPENDS:=asterisk

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=PeDitX <https://t.me/peditx>

PKG_INSTALL:=1

FILES:=files
LUCI_FILES:=files/www/luci-static/asterisk/sip_manager.lua
LUCI_WEB_FILES:=files/www/luci-static/asterisk/sip_manager.html

SCRIPTS:=files/etc/asterisk/create_sip_user.sh \
         files/etc/asterisk/delete_sip_user.sh

ASTERISK_CONF:=files/etc/asterisk/extensions.conf

define Package/$(PKG_NAME)/description
    Asterisk SIP management for OpenWrt Luci interface
endef

define Package/$(PKG_NAME)/install
    # Install Asterisk configuration
    $(INSTALL_DIR) $(1)/etc/asterisk
    $(INSTALL_DATA) $(ASTERISK_CONF) $(1)/etc/asterisk/

    # Install LuCI static files
    $(INSTALL_DIR) $(1)/www/luci-static/asterisk
    $(INSTALL_DATA) $(LUCI_FILES) $(1)/www/luci-static/asterisk/
    $(INSTALL_DATA) $(LUCI_WEB_FILES) $(1)/www/luci-static/asterisk/

    # Install scripts
    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) $(SCRIPTS) $(1)/usr/bin/

    # Install postinst script
    $(INSTALL_DIR) $(1)/etc/uci-defaults
    $(INSTALL_BIN) files/etc/uci-defaults/postinst $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
