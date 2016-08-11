//
//  XFDialogInputView.h
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
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

/** 文本框数组 NSArray类型*/
extern const NSString *XFDialogInputFields;
/** 文本框类弄 枚举UIKeyboardType类型*/
extern const NSString *XFDialogInputTypeKey;
/** 文本框是否是密码 BOOL类型*/
extern const NSString *XFDialogInputIsPasswordKey;
/** 文本框Placeholder NSString类型*/
extern const NSString *XFDialogInputPlaceholderKey;
/** 文本框光标颜色 UIColor类型*/
extern const NSString *XFDialogInputHintColor;
/** 文本框文字颜色 UIColor类型*/
extern const NSString *XFDialogInputTextColor;
/** 文本框Margin float类型*/
extern const NSString *XFDialogInputMargin;
/** 文本框高度 float类型*/
extern const NSString *XFDialogInputHeight;
/** 文本框字体大小 float类型*/
extern const NSString *XFDialogInputFontSize;
/** 文本框单项验证数组 NSArray类型*/
extern const NSString *XFDialogValidatorMatchers;
/** 文本框多项验证数组 NSArray类型*/
extern const NSString *XFDialogMultiValidatorMatchers;
/** 文本框密码明文设置 NSDictionary类型*/
extern const NSString *XFDialogInputPasswordEye;
/** 文本框密码图标大小 float类型*/
extern const NSString *XFDialogInputEyeSize;
/** 文本框显示密文图标名 NSString类型*/
extern const NSString *XFDialogInputEyeOpenImage;
/** 文本框明文图标名 NSString类型*/
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
 *  @param errorCallBack 错误回调
 */
+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(commitClickBlock)commitCallBack errorCallBack:(errorHappenBlock)errorCallBack;
/**
 *  当输入有误时获得焦点
 */
- (void)focusErrorEventInputView;
@end
