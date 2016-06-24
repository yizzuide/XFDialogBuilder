//
//  XFDialogInputView.h
//  CreativeButton
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 RightBrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFDialogCommandButton.h"

#define XFInputDefH 49
#define XFInputDefMargin 15
#define XFInputDefFontSize 15
#define ValidatorConditionKey @"conditionKey"
#define ValidatorErrorKey @"errorKey"


typedef BOOL(^ValidatorBlock)(UITextField *textfield);
typedef BOOL(^ValidatorsBlock)(NSArray<UITextField *> *textfield);

extern const NSString *XFDialogInputFields;
extern const NSString *XFDialogInputTypeKey;
extern const NSString *XFDialogInputIsPasswordKey;
extern const NSString *XFDialogInputPlaceholderKey;
extern const NSString *XFDialogInputHintColor;
extern const NSString *XFDialogInputTextColor;
extern const NSString *XFDialogInputMargin;
extern const NSString *XFDialogInputHeight;
extern const NSString *XFDialogInputFontSize;
extern const NSString *XFDialogValidatorMatchers;
extern const NSString *XFDialogMultiValidatorMatchers;

extern const NSString *XFDialogInputPasswordEye;
extern const NSString *XFDialogInputEyeSize;
extern const NSString *XFDialogInputEyeOpenImage;
extern const NSString *XFDialogInputEyeCloseImage;

typedef void(^errorHappenBlock)(NSString *errorMessage);

@class XFMaskView;
@interface XFDialogInput : XFDialogCommandButton

@property (nonatomic, copy, readonly) errorHappenBlock errorCallBack;
/**
 *  显示对话框
 *
 *  @param title          标题
 *  @param attrs          对话框属性
 *  @param commitCallBack 确定输入内容的回调
 *
 */
+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(commitClickBlock)commitCallBack errorCallBack:(errorHappenBlock)errorCallBack;
/**
 *  当输入有误时获得焦点
 */
- (void)focusErrorEventInputView;
@end
