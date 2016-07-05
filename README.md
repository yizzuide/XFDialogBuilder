# XFDialogBuilder

[![CocoaPods](https://img.shields.io/badge/cocoapods-v1.0.2-brightgreen.svg)](http://cocoadocs.org/docsets/XFSettings)
![Language](https://img.shields.io/badge/language-ObjC-orange.svg)
![License](https://img.shields.io/npm/l/express.svg)
![Version](https://img.shields.io/badge/platform-ios6%2B-green.svg)

巨匠级可配置型IOS对话框，使用者定制蒙版层背景、窗口大小、UI主题、文本内容、字体大小、布局内容、弹出消失动画引擎。

![XFDialogBuilder usage](./ScreenShot/usage.gif)

##XFDialogBuilder框架特点
1.快速开发，使用json搭建界面

2.相比其它高度封装+酷炫框架([SIAlertView](https://github.com/Sumi-Interactive/SIAlertView)、[SCLAlertView](https://github.com/dogo/SCLAlertView)、[AMSmoothAlertView](https://github.com/mtonio91/AMSmoothAlert)等)，本框架UI定制性更强,，需求更符合国情，是真正能拿到自己项目用的

3.使用者能分别自定义弹入、弹出动画引擎，可使用IOS自带动画方式，也可用其它第三方引擎，如pop、MMTweenAnimation、JHChainableAnimations等（兼容所有UIView动画引擎的嵌入)

4.扩展性强，提供多种对话框类型，开发者可自己基于模板进行扩展

5.内置强大输入框验证系统，开发者可自定义配置验证规则

6.最低支持到IOS6

##安装
1、通过cocoapods
> pod 'XFDialogBuilder','1.0.2'

2、手动加入

把XFDialogBuilder整个目录拖入到工程，添加依赖库`pop`、`UITextView+Placeholder`。

##Demo运行注意
需要用命令行:

1.`cd ...XFDialogBuilderExample`("..."要根据自己的路径来)

2.`pod install`
