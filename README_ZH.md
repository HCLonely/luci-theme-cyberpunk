# Cyberpunk LuCI Theme

Cyberpunk 是一款面向 OpenWrt 路由器管理后台的深色 LuCI 主题，采用克制的赛博朋克 HUD 视觉风格。

[Document](/README.md) | [简体中文](/README_ZH.md)

## 特性

- 独立 LuCI 主题包：`luci-theme-cyberpunk`
- 深色优先配色，使用电青、玫红和绿色状态强调
- 赛博朋克登录标识和本地 HUD 风格背景
- 独立静态资源目录：`/luci-static/cyberpunk`
- 独立菜单模块：`menu-cyberpunk`
- UCI 配置命名空间：`cyberpunk`
- 壁纸 RPC helper：`luci.cyberpunk_wallpaper`

## 界面预览

### 桌面端

![赛博朋克主题桌面端登录页](Screenshots/login-desktop.png?raw=true)

![赛博朋克主题桌面端状态页](Screenshots/overview-desktop.png?raw=true)

### 移动端

<p align="center">
  <img src="Screenshots/login-mobile.png?raw=true" alt="赛博朋克主题移动端登录页" width="42%">
  <img src="Screenshots/overview-mobile.png?raw=true" alt="赛博朋克主题移动端状态页" width="42%">
</p>

## 构建

将本包放入 OpenWrt buildroot 的 package feed 中，按普通 LuCI 包构建。

```sh
make package/luci-theme-cyberpunk/compile V=s
```

## 安装

- OpenWrt ≤ 24.10

```sh
opkg install luci-theme-cyberpunk-*.apk
```

- OpenWrt > 24.10

> OpenWrt 24.10 之后的版本由于签名密钥问题，请使用以下命令安装下载的 APK 软件包：

```sh
apk add --allow-untrusted luci-theme-cyberpunk-*.apk
```

## Credits

- [luci-theme-material](https://github.com/LuttyYang/luci-theme-material/)
- [luci-theme-argon](https://github.com/jerrykuku/luci-theme-argon)
