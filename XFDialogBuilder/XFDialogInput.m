//
//  XFDialogInputView.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFDialogInput.h"
#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

const NSString *XFDialogInputFields = @"XFDialogInputFields";
const NSString *XFDialogInputTypeKey = @"XFDialogInputType";
const NSString *XFDialogInputIsPasswordKey = @"XFDialogInputIsPassword";
const NSString *XFDialogInputPlaceholderKey = @"XFDialogInputPlaceholder";
const NSString *XFDialogInputHintColor = @"XFDialogInputHintColor";
const NSString *XFDialogInputTextColor = @"XFDialogInputTextColor";
const NSString *XFDialogInputMargin = @"XFDialogInputMargin";
const NSString *XFDialogInputHeight = @"XFDialogInputHeight";
const NSString *XFDialogInputFontSize = @"XFDialogInputFontSize";

const NSString *XFDialogValidatorMatchers = @"XFDialogValidatorMatchers";
const NSString *XFDialogMultiValidatorMatchers = @"XFDialogMultiValidatorMatchers";

// 密码开关
const NSString *XFDialogInputPasswordEye = @"XFDialogInputPasswordEye";
const NSString *XFDialogInputEyeSize = @"XFDialogInputEyeSize";
const NSString *XFDialogInputEyeOpenImage = @"XFDialogInputEyeOpenImage";
const NSString *XFDialogInputEyeCloseImage = @"XFDialogInputEyeCloseImage";





@interface XFDialogInput () <UITextFieldDelegate>

@property (nonatomic, copy, readwrite) errorHappenBlock errorCallBack;

@property (nonatomic, strong) NSMutableArray<UITextField *> *inputTextFields;
@property (nonatomic, assign) NSInteger currentNextIndex;
// 侦听对象
@property (nonatomic, weak) id<NSObject> observer;
@end

@implementation XFDialogInput

- (NSMutableArray<UITextField *> *)inputTextFields
{
    if (_inputTextFields == nil) {
        NSMutableArray<UITextField *> *textFileds = [NSMutableArray<UITextField *> array];
        _inputTextFields = textFileds;
    }
    return _inputTextFields;
}

+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(commitClickBlock)commitCallBack errorCallBack:(errorHappenBlock)errorCallBack
{
    XFDialogInput *dialogView = [super dialogWithTitle:title attrs:attrs commitCallBack:commitCallBack];
    dialogView.errorCallBack = errorCallBack;
    return dialogView;
}

- (void)addContentView
{
    [super addContentView];
    
    // 添加输入框
    NSArray *inputFields = self.attrs[XFDialogInputFields];
    NSUInteger count = inputFields.count;
    for (int i = 0; i < count; i++) {
        NSDictionary *inputFieldDesc = inputFields[i];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.keyboardType = XFDialogRealValueWithTypeForRef(inputFieldDesc, XFDialogInputTypeKey, intValue, UIKeyboardTypeDefault);
        textField.secureTextEntry = XFDialogRealValueWithTypeForRef(inputFieldDesc, XFDialogInputIsPasswordKey, boolValue, NO);
        textField.placeholder =  XFDialogRealValueForRef(inputFieldDesc, XFDialogInputPlaceholderKey, @"请输入内容");
        textField.tintColor = XFDialogRealValue(XFDialogInputHintColor, [UIColor blackColor]);
        textField.textColor = XFDialogRealValue(XFDialogInputTextColor, [UIColor blackColor]);
        if (i == count - 1) {
            textField.returnKeyType = UIReturnKeyDone;
        }else{
            textField.returnKeyType = UIReturnKeyNext;
        }
        textField.enablesReturnKeyAutomatically = YES;
        textField.textAlignment = NSTextAlignmentLeft;
        UIView *leftview = [[UIView alloc] init];
        leftview.size = CGSizeMake(7, 7);
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = leftview;
        
        NSDictionary *inputPasswordEye = inputFieldDesc[XFDialogInputPasswordEye];
        if (inputPasswordEye) {
            UIButton *wordEyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            wordEyeButton.backgroundColor = [UIColor redColor];
            int eyeSize = XFDialogRealValueWithTypeForRef(inputPasswordEye, XFDialogInputEyeSize, intValue, 32);
            wordEyeButton.size = CGSizeMake(eyeSize, eyeSize);
            [wordEyeButton setImage:[UIImage imageNamed:inputPasswordEye[XFDialogInputEyeOpenImage]] forState:UIControlStateNormal];
            [wordEyeButton setImage:[UIImage imageNamed:inputPasswordEye[XFDialogInputEyeCloseImage]] forState:UIControlStateSelected];

            [wordEyeButton addTarget:self action:@selector(secureTextChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            textField.rightViewMode = UITextFieldViewModeWhileEditing;
            textField.rightView = wordEyeButton;
        }
        
        
        textField.layer.cornerRadius = XFDialogRealValueWithFloatType(XFDialogCornerRadius, XFDialogDefCornerRadius);
        textField.layer.borderWidth = 1;
        textField.layer.borderColor =  XFDialogRealValueWithType(XFDialogLineColor, CGColor , [UIColor grayColor].CGColor);
        
        textField.font = XFDialogRealFont(XFDialogInputFontSize, XFInputDefFontSize);
        
        textField.delegate = self;
        [self addSubview:textField];
        __weak UITextField *substituteTF = textField;
        [self.inputTextFields addObject:substituteTF];
    }
    
//    LogError(@"inputTFS : %zd",self.inputTextFields.count);
    
    WS(weakSelf)
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull noti) {
        CGFloat keyY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat kScreenH = [[UIScreen mainScreen] bounds].size.height;
        
        // 使动画与键盘保持一致
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            weakSelf.transform = CGAffineTransformMakeTranslation(0, (keyY - kScreenH) * 0.35);
        }];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf.inputTextFields[0] becomeFirstResponder];
    });
}

- (void)secureTextChangeAction:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    UITextField *textField = (UITextField *)btn.superview;
    textField.secureTextEntry = !textField.isSecureTextEntry;
}

// 当获得焦点时
/*- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = self.attrs[XFDialogLineColor] ? [self.attrs[XFDialogLineColor] CGColor] : [UIColor grayColor].CGColor;
    // 重置焦点
    NSUInteger count = self.inputTextFields.count;
    for (int i = 0; i < count; i++) {
        if (textField == self.inputTextFields[i]) {
            self.currentNextIndex = i;
            break;
        }
    }
}*/
// 用户输入时
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textField.layer.borderColor = XFDialogRealValueWithType(XFDialogLineColor, CGColor , [UIColor grayColor].CGColor);
    return YES;
}
// 进一步动作事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.inputTextFields[++self.currentNextIndex] becomeFirstResponder];
    }else if(textField.returnKeyType == UIReturnKeyDone)
    {
        [self endEditing:YES];
        [self commitAction:nil];
        self.currentNextIndex = 0;
    }
    return YES;
}
// 完成编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentNextIndex = 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = XFDialogRealValueWithFloatType(XFDialogInputMargin, XFInputDefMargin);
    CGFloat inputH = XFDialogRealValueWithFloatType(XFDialogInputHeight, XFInputDefH);
    CGFloat topH = [self realTitleHeight];
    NSUInteger count = self.inputTextFields.count;
    for (int i = 0; i < count; i++) {
         UIView *view = self.inputTextFields[i];
        view.size = CGSizeMake(self.dialogSize.width - margin, inputH);
        view.x = (self.width - view.size.width) * 0.5;
        view.y = topH + margin;
        topH = CGRectGetMaxY(view.frame);
    }
    
    
}

- (CGSize)dialogSize
{
    CGFloat margin = XFDialogRealValueWithFloatType(XFDialogInputMargin, XFInputDefMargin);
    CGFloat inputH = XFDialogRealValueWithFloatType(XFDialogInputHeight, XFInputDefH);
    CGFloat allInputFieldsH = inputH * self.inputTextFields.count;
    CGFloat allMarginH = margin * (self.inputTextFields.count + 1);
    CGFloat bottomButtonH = [self realCommandButtonHeight];
    CGFloat topH = [self realTitleHeight];
    
    return CGSizeMake(XFDialogDefW, topH + allInputFieldsH + allMarginH + bottomButtonH);
}

- (NSString *)inputText
{
    return self.inputTextFields.lastObject.text;
}

- (void)focusErrorEventInputView
{
    [self.inputTextFields.lastObject becomeFirstResponder];
    self.inputTextFields.lastObject.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)onErrorWithMesssage:(NSString *)errorMessage
{
    if (self.errorCallBack) {
        self.errorCallBack(errorMessage);
    }
}

- (NSString *)validate
{

    NSArray *matchers = self.attrs[XFDialogValidatorMatchers];
    if (matchers.count > 0) {
        // 单项验证
        NSUInteger inputCount = self.inputTextFields.count;
        for (int i = 0; i < inputCount; i++) {
            UITextField *textfield = self.inputTextFields[i];
            NSUInteger matcherCount = matchers.count;
            for (int i = 0; i < matcherCount; i++) {
                NSDictionary *matcher = matchers[i];
                ValidatorBlock condition = matcher[ValidatorConditionKey];
                NSString *error = matcher[ValidatorErrorKey];
                if (condition(textfield)) {
                    textfield.layer.borderColor = [UIColor redColor].CGColor;
                    [textfield becomeFirstResponder];
                    return error;
                }
            }
        }
    }
    
    // 多项验证
    NSArray *multi_matchers = self.attrs[XFDialogMultiValidatorMatchers];
    NSUInteger matcherCount = multi_matchers.count;
    for (int i = 0; i < matcherCount; i++) {
        NSDictionary *multi_matcher = multi_matchers[i];
        ValidatorsBlock condition = multi_matcher[ValidatorConditionKey];
        NSString *error = multi_matcher[ValidatorErrorKey];
        if (condition(self.inputTextFields)) {
            NSUInteger inputCount = self.inputTextFields.count;
            for (int i = 0; i < inputCount; i++) {
                self.inputTextFields[i].layer.borderColor = [UIColor redColor].CGColor;
            }
            return error;
        }
    }
    
    return nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}
@end
