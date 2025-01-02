include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-asterisk
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKGARCH:=all

PKG_DEPENDS:=asterisk
PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=PeDitX <https://t.me/peditx>

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Asterisk SIP management for OpenWrt LuCI interface
  DEPENDS:=$(PKG_DEPENDS)
endef

define Package/$(PKG_NAME)/description
  Asterisk SIP management for OpenWrt LuCI interface
endef

define Package/$(PKG_NAME)/install
    # Install Asterisk configuration
    $(INSTALL_DIR) $(1)/etc/asterisk
    $(INSTALL_DATA) files/etc/asterisk/pjsip.conf $(1)/etc/asterisk/

    # Install LuCI files
    $(INSTALL_DIR) $(1)/www/luci-static/asterisk
    $(INSTALL_DATA) files/www/luci-static/asterisk/sip_manager.lua $(1)/www/luci-static/asterisk/
    $(INSTALL_DATA) files/www/luci-static/asterisk/sip_manager.html $(1)/www/luci-static/asterisk/
    $(INSTALL_DATA) files/www/luci-static/asterisk/brand.png $(1)/www/luci-static/asterisk/

    # Install scripts
    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) files/etc/asterisk/create_sip_user.sh $(1)/usr/bin/
    $(INSTALL_BIN) files/etc/asterisk/delete_sip_user.sh $(1)/usr/bin/

    # Install postinst script
    $(INSTALL_DIR) $(1)/etc/uci-defaults
    $(INSTALL_BIN) files/etc/uci-defaults/postinst $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
