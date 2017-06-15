//
//  XFOptionButtonView.h
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFDialogFrame.h"

#define XFDialogOptionButtonDefHeight 49.f
#define XFDialogCommandButtonLineDefH 1.f
#define XFDialogOptionButtonDefFontSize 17

/** 可选按钮文字列表*/
extern const NSString *XFDialogOptionTextList;
/** 可选按钮图标列表*/
extern const NSString *XFDialogOptionImageList;
/** 可选按钮内容间距*/
extern const NSString *XFDialogOptionButtonMarginBetweenContent;
/** 可选按钮文本颜色*/
extern const NSString *XFDialogOptionTextColor;
/** 可选按钮取消文本颜色*/
extern const NSString *XFDialogOptionCancelTextColor;
/** 可选按钮是否禁用取消按钮*/
extern const NSString *XFDialogOptionCancelDisable;
/** 可选按钮高度*/
extern const NSString *XFDialogOptionButtonHeight;
/** 可选按钮文本字体大小*/
extern const NSString *XFDialogOptionButtonFontSize;


@interface XFDialogOptionButton : XFDialogFrame


@end
