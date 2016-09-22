//
//  XFDecideView.h
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/19.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFDialogFrame.h"

#define XFDialogCommandButtonDefHeight 49.f
#define XFDialogCommitButtonDefFontSize 17

/** 按钮高度 float类型*/
extern const NSString *XFDialogCommandButtonHeight;
/** 取消按钮标题颜色 UIColor类型*/
extern const NSString *XFDialogCancelButtonTitleColor;
/** 确定按钮标题颜色 UIColor类型*/
extern const NSString *XFDialogCommitButtonTitleColor;
/** 取消按钮标题文字 NSString类型*/
extern const NSString *XFDialogCancelButtonTitle;
/** 确定按钮标题文字 NSString类型*/
extern const NSString *XFDialogCommitButtonTitle;
/** 按钮标题文字字体大小 float类型*/
extern const NSString *XFDialogCommitButtonFontSize;
/** 禁用中线 BOOL类型*/
extern const NSString *XFDialogCommitButtonMiddleLineDisable;
/** 禁用取消按钮 */
extern const NSString *XFDialogCommitButtonCancelDisable;


@interface XFDialogCommandButton : XFDialogFrame

@property (nonatomic, assign, readonly) CGFloat buttonH;
/**
 *  子控件可以覆盖确定时的输入内容，用于作为参数输出给commitCallBack回调，默认返回"commit"
 */
@property (nonatomic, copy) id inputData;

/**
 *  子类可以调用确定按钮事件
 *
 */
- (void)commitAction:(UIButton *)commitButton;
/**
 *  子控件可以覆盖确定按钮事件发生错误
 *
 *  @param errorMessage 错误消息
 */
- (void)onErrorWithMesssage:(NSString *)errorMessage;

/**
 *  子控件是否有验证方法，没有或验证成功返回nil
 *
 *  @return 返回错误字符串
 */
- (NSString *)validate;
/**
 *  命令按钮高度
 *
 */
- (CGFloat)realCommandButtonHeight;
@end
