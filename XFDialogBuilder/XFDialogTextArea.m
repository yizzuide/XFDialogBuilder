//
//  XFDialogTextArea.m
//  XFDialogBuilder
//
//  Created by yizzuide on 16/3/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDialogTextArea.h"
#import "XFDialogMacro.h"
#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFTextView.h"

const NSString *XFDialogTextAreaTypeKey = @"XFDialogTextAreaTypeKey";
const NSString *XFDialogTextAreaPlaceholderKey = @"XFDialogTextAreaPlaceholderKey";
const NSString *XFDialogTextAreaPlaceholderColorKey = @"XFDialogTextAreaPlaceholderColorKey";
const NSString *XFDialogTextAreaHintColor = @"XFDialogTextAreaHintColor";
const NSString *XFDialogTextAreaTextColor = @"XFDialogTextAreaTextColor";
const NSString *XFDialogTextAreaMargin = @"XFDialogTextAreaMargin";
const NSString *XFDialogTextAreaHeight = @"XFDialogTextAreaHeight";
const NSString *XFDialogTextAreaFontSize = @"XFDialogTextAreaFontSize";

typedef BOOL(^ValidatorBlock)(UITextView *textView);

@interface XFDialogTextArea () <UITextViewDelegate>

@property (nonatomic, copy, readwrite) errorHappenBlock errorCallBack;
@property (nonatomic, weak) XFTextView *textView;
@end

@implementation XFDialogTextArea


+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(commitClickBlock)commitCallBack errorCallBack:(errorHappenBlock)errorCallBack
{
    XFDialogTextArea *dialogView = [super dialogWithTitle:title attrs:attrs commitCallBack:commitCallBack];
    dialogView.errorCallBack = errorCallBack;
    return dialogView;
}

- (void)addContentView
{
    [super addContentView];
    
    XFTextView *textView = [[XFTextView alloc] init];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.spellCheckingType = UITextSpellCheckingTypeNo;
    textView.keyboardType = XFDialogRealValueWithType(XFDialogTextAreaTypeKey, intValue, UIKeyboardTypeDefault);
    textView.tintColor = XFDialogRealValue(XFDialogTextAreaHintColor, [UIColor blackColor]);
    textView.placeHodler = XFDialogRealValue(XFDialogTextAreaPlaceholderKey, @"请输入内容");
    textView.placeHodlerColor = XFDialogRealValue(XFDialogTextAreaPlaceholderColorKey, [UIColor blackColor]);
    textView.textColor = XFDialogRealValue(XFDialogTextAreaTextColor, [UIColor blackColor]);
    textView.enablesReturnKeyAutomatically = YES;
    textView.textAlignment = NSTextAlignmentLeft;
    textView.layer.cornerRadius = XFDialogRealValueWithFloatType(XFDialogCornerRadius, XFDialogDefCornerRadius);
    textView.layer.borderWidth = 1;
    textView.layer.borderColor =  XFDialogRealValueWithType(XFDialogLineColor, CGColor , [UIColor grayColor].CGColor);
    
    textView.font = XFDialogRealFont(XFDialogTextAreaFontSize, XFTextAreaDefFontSize);
    textView.delegate = self;
    
    [self addSubview:textView];
    self.textView = textView;
    
    WS(weakSelf)
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull noti) {
        CGFloat keyY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat kScreenH = [[UIScreen mainScreen] bounds].size.height;
        
        // 使动画与键盘保持一致
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            weakSelf.transform = CGAffineTransformMakeTranslation(0, (keyY - kScreenH) * 0.45);
        }];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf.textView becomeFirstResponder];
    });
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 检测完成
    /*if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }*/
    textView.layer.borderColor = XFDialogRealValueWithType(XFDialogLineColor, CGColor , [UIColor grayColor].CGColor);
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self endEditing:YES];
    //[self commitAction:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = XFDialogRealValueWithFloatType(XFDialogTextAreaMargin, XFTextAreaDefMargin);
    CGFloat textAreaH = XFDialogRealValueWithFloatType(XFDialogTextAreaHeight, XFTextAreaDefH);
    CGFloat topH = [self realTitleHeight];
    
    UIView *view = self.textView;
    view.size = CGSizeMake(self.dialogSize.width - margin, textAreaH);
    view.x = (self.width - view.size.width) * 0.5;
    view.y = topH + margin;
}

- (CGSize)dialogSize
{
    CGFloat margin = XFDialogRealValueWithFloatType(XFDialogTextAreaMargin, XFTextAreaDefMargin);
    CGFloat textAreaH = XFDialogRealValueWithFloatType(XFDialogTextAreaHeight, XFTextAreaDefH);
    CGFloat allMarginH = margin * 2;
    CGFloat bottomButtonH = [self realCommandButtonHeight];
    CGFloat topH = [self realTitleHeight];
    return CGSizeMake(XFDialogDefW, topH + textAreaH + allMarginH + bottomButtonH);
}

- (NSString *)inputText
{
    [self endEditing:YES];
    return self.textView.text;
}

- (void)focusErrorEventInputView
{
    [self.textView becomeFirstResponder];
    self.textView.layer.borderColor = [UIColor redColor].CGColor;
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
        UITextView *textView = self.textView;
        NSUInteger matcherCount = matchers.count;
        for (int i = 0; i < matcherCount; i++) {
            NSDictionary *matcher = matchers[i];
            ValidatorBlock condition = matcher[ValidatorConditionKey];
            NSString *error = matcher[ValidatorErrorKey];
            if (condition(textView)) {
                textView.layer.borderColor = [UIColor redColor].CGColor;
                [textView becomeFirstResponder];
                return error;
            }
        }
    }
    return nil;
}

@end
