//
//  XFDecideView.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/19.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFDialogCommandButton.h"
#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"


const NSString *XFDialogCommandButtonHeight = @"XFDialogCommandButtonHeight";
const NSString *XFDialogCancelButtonTitleColor = @"XFDialogCancelButtonTitleColor";
const NSString *XFDialogCommitButtonTitleColor = @"XFDialogCommitButtonTitleColor";
const NSString *XFDialogCancelButtonTitle = @"XFDialogCancelButtonTitle";
const NSString *XFDialogCommitButtonTitle = @"XFDialogCommitButtonTitle";
const NSString *XFDialogCommitButtonFontSize = @"XFDialogCommitButtonFontSize";
const NSString *XFDialogCommitButtonMiddleLineDisable = @"XFDialogCommitButtonMiddleLineDisable";
const NSString *XFDialogCommitButtonCancelDisable = @"XFDialogCommitButtonCancelDisable";

@interface XFDialogCommandButton ()

@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *commitButton;
@property (nonatomic, assign, readwrite) CGFloat buttonH;

@property (nonatomic, weak) UIView *buttonTopLine;
@property (nonatomic, weak) UIView *buttonMiddleLine;

@end

@implementation XFDialogCommandButton

- (UIView *)buttonTopLine
{
    if (_buttonTopLine == nil) {
        UIView *lineView = [[UIView alloc] init];
        lineView.height = XFDialogRealValueWithFloatType(XFDialogLineWidth, XFDialogLineDefW);
        lineView.backgroundColor = XFDialogRealValue(XFDialogLineColor, [UIColor grayColor]);
        
        [self addSubview:lineView];
        
        _buttonTopLine = lineView;
    }
    return _buttonTopLine;
}

- (UIView *)buttonMiddleLine
{
    if (_buttonMiddleLine == nil) {
        UIView *lineView = [[UIView alloc] init];
        lineView.width = XFDialogRealValueWithFloatType(XFDialogLineWidth, XFDialogLineDefW);
        lineView.height = [self realCommandButtonHeight];
        lineView.backgroundColor = XFDialogRealValue(XFDialogLineColor, [UIColor grayColor]);
        
        [self addSubview:lineView];
        
        _buttonMiddleLine = lineView;
    }
    return _buttonMiddleLine;
}

- (void)addContentView
{
    [super addContentView];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    //cancelButton.backgroundColor = [UIColor purpleColor];
    [cancelButton setTitle:XFDialogRealValue(XFDialogCancelButtonTitle, @"取消") forState:UIControlStateNormal];
    [cancelButton setTitleColor:XFDialogRealValue(XFDialogCancelButtonTitleColor, [UIColor blackColor]) forState:UIControlStateNormal];
    cancelButton.titleLabel.font = XFDialogRealFont(XFDialogCommitButtonFontSize, XFDialogCommitButtonDefFontSize);
    
    [self addSubview:cancelButton];
    self.cancelButton = cancelButton;
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 确定按钮
    UIButton *commitButton = [[UIButton alloc] init];
    [commitButton setTitle:XFDialogRealValue(XFDialogCommitButtonTitle, @"确定") forState:UIControlStateNormal];
    [commitButton setTitleColor: XFDialogRealValue(XFDialogCommitButtonTitleColor, [UIColor redColor]) forState:UIControlStateNormal];
    commitButton.titleLabel.font = XFDialogRealFont(XFDialogCommitButtonFontSize, XFDialogCommitButtonDefFontSize);
    [self addSubview:commitButton];
    self.commitButton = commitButton;
    [commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加线条
    [self buttonTopLine];
    
    // 如果禁用Cancel按钮,那么就禁用中线
    if(XFDialogRealValueWithType(XFDialogCommitButtonCancelDisable, boolValue, NO)){
        self.attrs[XFDialogCommitButtonMiddleLineDisable] = @YES;
    }
    if (!XFDialogRealValueWithType(XFDialogCommitButtonMiddleLineDisable, boolValue, NO)) {
        [self buttonMiddleLine];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonH = [self realCommandButtonHeight];
    
    // 如果禁用Cancel按钮
    if(XFDialogRealValueWithType(XFDialogCommitButtonCancelDisable, boolValue, NO)){
        self.commitButton.y = self.dialogSize.height - buttonH;
        self.commitButton.width = self.dialogSize.width;
        self.commitButton.height = buttonH;
    }else{
        self.cancelButton.y = self.dialogSize.height - buttonH;
        self.cancelButton.width = self.dialogSize.width * 0.5;
        self.cancelButton.height = buttonH;
        
        self.commitButton.x = self.dialogSize.width * 0.5;
        self.commitButton.y = self.dialogSize.height - buttonH;
        self.commitButton.width = self.dialogSize.width * 0.5;
        self.commitButton.height = buttonH;
    }
    // 布局顶部线条
    self.buttonTopLine.y = self.commitButton.y - 1;
    self.buttonTopLine.width = self.dialogSize.width;
    
    // 布局中线
    if (!XFDialogRealValueWithType(XFDialogCommitButtonMiddleLineDisable, boolValue, NO)) {
        self.buttonMiddleLine.y = self.commitButton.y;
        self.buttonMiddleLine.x = (self.dialogSize.width - self.buttonMiddleLine.width) * 0.5;
        self.buttonMiddleLine.height = buttonH;
    }
}

- (CGFloat)realCommandButtonHeight
{
    return XFDialogRealValueWithFloatType(XFDialogCommandButtonHeight, XFDialogCommandButtonDefHeight);
}


- (void)cancelAction:(UIButton *)cancelButton
{
    [self endEditing:YES];
    [self.maskView hideWithAnimationBlock:self.cancelAnimationEngineBlock];
}

- (void)commitAction:(UIButton *)commitButton { 
    NSString *errorMessage = [self validate];
    if (!errorMessage) {
        if (self.commitCallBack) {
            [self endEditing:YES];
            self.commitCallBack([self inputData]);
        }
    }else{
        // 发给子类有错误
        [self onErrorWithMesssage:errorMessage];
    }
}

- (void)onErrorWithMesssage:(NSString *)errorMessage{}

- (id)inputData
{
    return @"commit";
}

- (NSString *)validate {
    return nil;
}
@end
