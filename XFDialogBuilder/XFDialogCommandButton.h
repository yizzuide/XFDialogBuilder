//
//  XFDecideView.h
//  CreativeButton
//
//  Created by yizzuide on 15/9/19.
//  Copyright © 2015年 RightBrain. All rights reserved.
//

#import "XFDialogFrame.h"

#define XFDialogCommandButtonDefHeight 49.f
#define XFDialogCommitButtonDefFontSize 17

extern const NSString *XFDialogCommandButtonHeight;
extern const NSString *XFDialogCancelButtonTitleColor;
extern const NSString *XFDialogCommitButtonTitleColor;
extern const NSString *XFDialogCancelButtonTitle;
extern const NSString *XFDialogCommitButtonTitle;
extern const NSString *XFDialogCommitButtonFontSize;
extern const NSString *XFDialogCommitButtonMiddleLineDisable;


@interface XFDialogCommandButton : XFDialogFrame

@property (nonatomic, assign, readonly) CGFloat buttonH;
/**
 *  子类要设置确定时的输入内容
 */
@property (nonatomic, copy) NSString *inputText;

/**
 *  子类可以调用确定按钮事件
 *
 */
- (void)commitAction:(UIButton *)commitButton;
/**
 *  子类可以覆盖确定按钮事件发生错误
 *
 *  @param errorMessage 错误消息
 */
- (void)onErrorWithMesssage:(NSString *)errorMessage;

/**
 *  子类是否有验证方法，没有或验证成功返回ni
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
