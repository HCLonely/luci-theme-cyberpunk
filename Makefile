#
# Copyright (C) 2008-2019 Jerrykuku
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Cyberpunk Theme
LUCI_DEPENDS:=+wget +jsonfilter
PKG_VERSION:=1.0.0
# Use the build date (UTC+8), matching the release workflow timezone.
PKG_RELEASE:=$(shell TZ=Asia/Shanghai date +%Y%m%d)

CONFIG_LUCI_CSSTIDY:=

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
