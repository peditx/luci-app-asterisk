PKG_NAME:=luci-app-asterisk
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

DEPENDS:=+asterisk +asterisk-pjsip +asterisk-bridge-simple +asterisk-codec-alaw +asterisk-codec-ulaw +asterisk-res-rtp-asterisk

include $(TOPDIR)/rules.mk
