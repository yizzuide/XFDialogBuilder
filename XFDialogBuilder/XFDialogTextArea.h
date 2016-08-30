//
//  XFDialogTextArea.h
//  XFDialogBuilder
//
//  Created by yizzuide on 16/3/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDialogCommandButton.h"

#define XFTextAreaDefH 120
#define XFTextAreaDefMargin 15
#define XFTextAreaDefFontSize 15
#define ValidatorConditionKey @"conditionKey"
#define ValidatorErrorKey @"errorKey"



extern const NSString *XFDialogTextAreaTypeKey;
extern const NSString *XFDialogTextAreaPlaceholderKey;
extern const NSString *XFDialogTextAreaPlaceholderColorKey;
extern const NSString *XFDialogTextAreaHintColor;
extern const NSString *XFDialogTextAreaTextColor;
extern const NSString *XFDialogTextAreaMargin;
extern const NSString *XFDialogTextAreaHeight;
extern const NSString *XFDialogTextAreaFontSize;
extern const NSString *XFDialogValidatorMatchers;

typedef void(^errorHappenBlock)(NSString *errorMessage);

@interface XFDialogTextArea : XFDialogCommandButton

/**
 *  显示对话框
 *
 *  @param title          标题
 *  @param attrs          对话框属性
 *  @param commitCallBack 确定输入内容的回调
 *
 */
+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(CommitClickBlock)commitCallBack errorCallBack:(errorHappenBlock)errorCallBack;

- (void)focusErrorEventInputView;
@end
