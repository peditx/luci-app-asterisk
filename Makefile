PKG_NAME:=luci-app-asterisk
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

DEPENDS:=+asterisk +asterisk-pjsip +asterisk-bridge-simple +asterisk-codec-alaw +asterisk-codec-ulaw +asterisk-res-rtp-asterisk

include $(TOPDIR)/rules.mk
define Package/luci-app-asterisk
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Asterisk Web UI
  DEPENDS:=$(DEPENDS)
endef

define Package/luci-app-asterisk/install

    $(INSTALL_DIR) $(1)/etc/asterisk
    $(INSTALL_DIR) $(1)/etc/init.d

    $(INSTALL_DATA) ./files/etc/asterisk/extensions.conf $(1)/etc/asterisk/extensions.conf
    $(INSTALL_BIN) ./files/etc/init.d/postinst $(1)/etc/init.d/postinst
endef

$(eval $(call BuildPackage,luci-app-asterisk))
