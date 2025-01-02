include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-asterisk
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKGARCH:=all

PKG_DEPENDS:=asterisk

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=PeDitX <https://t.me/peditx>

define Package/luci-app-asterisk
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Applications
  TITLE:=Asterisk SIP Management for OpenWrt Luci Interface
  URL:=http://t.me/peditx
endef

define Package/luci-app-asterisk/description
  Asterisk SIP management for OpenWrt Luci interface
endef

define Package/luci-app-asterisk/install
  $(INSTALL_DIR) $(1)/etc/asterisk
  $(INSTALL_DATA) $(PKG_BUILD_DIR)/files/etc/asterisk/extensions.conf $(1)/etc/asterisk/

  $(INSTALL_DIR) $(1)/www/luci-static/asterisk
  $(INSTALL_DATA) $(PKG_BUILD_DIR)/files/www/luci-static/asterisk/sip_manager.lua $(1)/www/luci-static/asterisk/
  $(INSTALL_DATA) $(PKG_BUILD_DIR)/files/www/luci-static/asterisk/sip_manager.html $(1)/www/luci-static/asterisk/
  $(INSTALL_DATA) $(PKG_BUILD_DIR)/files/www/luci-static/asterisk/brand.png $(1)/www/luci-static/asterisk/

  $(INSTALL_DIR) $(1)/usr/bin
  $(INSTALL_BIN) $(PKG_BUILD_DIR)/files/usr/bin/create_sip_user.sh $(1)/usr/bin/
  $(INSTALL_BIN) $(PKG_BUILD_DIR)/files/usr/bin/delete_sip_user.sh $(1)/usr/bin/

  $(INSTALL_DIR) $(1)/uci-defaults
  $(INSTALL_BIN) $(PKG_BUILD_DIR)/files/uci-defaults/postinst $(1)/uci-defaults/
endef

$(eval $(call BuildPackage,luci-app-asterisk))
