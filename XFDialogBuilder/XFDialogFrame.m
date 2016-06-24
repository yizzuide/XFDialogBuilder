//
//  XFDialogFrameView.m
//  CreativeButton
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 RightBrain. All rights reserved.
//

#import "XFDialogFrame.h"
#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"

const NSString *XFDialogMaskViewBackgroundColor = @"XFDialogMaskViewBackgroundColor";
const NSString *XFDialogMaskViewAlpha = @"XFDialogMaskViewAlpha";
const NSString *XFDialogSize = @"XFDialogSize";
const NSString *XFDialogCornerRadius = @"XFCornerRadius";
const NSString *XFDialogBackground = @"XFDialogBackground";
const NSString *XFDialogLineColor = @"XFDialogLineColor";
const NSString *XFDialogLineWidth = @"XFDialogLineWidth";
const NSString *XFDialogItemSpacing = @"XFDialogItemSpacing";

const NSString *XFDialogTitleViewBackgroundColor = @"XFDialogTitleViewBackgroundColor";
const NSString *XFDialogTitleColor = @"XFDialogTitleColor";
const NSString *XFDialogTitleFontSize= @"XFDialogTitleFontSize";
const NSString *XFDialogTitleViewHeight= @"XFDialogTitleViewHeight";
const NSString *XFDialogTitleAlignment = @"XFDialogTitleAlignment";
const NSString *XFDialogTitleIsMultiLine = @"XFDialogTitleIsMultiLine";

@interface XFDialogFrame ()

@property (nonatomic, strong, readwrite) NSDictionary *attrs;
@property (nonatomic, weak, readwrite) UILabel *titleLabel;
@property (nonatomic, copy,readwrite) commitClickBlock commitCallBack;
@property (nonatomic, weak, readwrite) XFMaskView *maskView;

@property (nonatomic, assign) CGFloat titleChangeValue;
@end

@implementation XFDialogFrame

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(commitClickBlock)commitCallBack
{
    XFDialogFrame *dialogFrameView = [[self alloc] init];
    dialogFrameView.attrs = attrs;
    dialogFrameView.commitCallBack = commitCallBack;
    
    dialogFrameView.layer.cornerRadius = XFDialogRealValueWithTypeForRef(attrs, XFDialogCornerRadius, floatValue, XFDialogDefCornerRadius);
    dialogFrameView.backgroundColor = XFDialogRealValueForRef(attrs, XFDialogBackground, [UIColor whiteColor]);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textColor = XFDialogRealValueForRef(attrs, XFDialogTitleColor, UIColorFromRGB(0x000000));
    titleLabel.textAlignment = XFDialogRealValueWithTypeForRef(attrs,XFDialogTitleAlignment,intValue,NSTextAlignmentCenter);
    if (attrs[XFDialogTitleIsMultiLine]) {
        titleLabel.numberOfLines = 0;
    }
    titleLabel.backgroundColor = XFDialogRealValueForRef(attrs, XFDialogTitleViewBackgroundColor, [UIColor grayColor]);
    titleLabel.font = XFDialogRealFontForRef(attrs, XFDialogTitleFontSize, XFDialogTitleDefFontSize);
    [dialogFrameView addSubview:titleLabel];
    dialogFrameView.titleLabel = titleLabel;
    
    [dialogFrameView addContentView];
    dialogFrameView.size = [dialogFrameView dialogSize];
    
    UIColor *maskViewBackColor = XFDialogRealValueForRef(attrs, XFDialogMaskViewBackgroundColor, [UIColor blackColor]);
    CGFloat maskViewAlpha = XFDialogRealValueWithTypeForRef(attrs, XFDialogMaskViewAlpha, floatValue, XFDialogMaskViewDefAlpha);
    XFMaskView *maskView = [XFMaskView dialogMaskViewWithBackColor:maskViewBackColor alpha:maskViewAlpha];
    maskView.dialogView = dialogFrameView;
    
    dialogFrameView.maskView = maskView;
    
    return dialogFrameView;
}

- (instancetype)showWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock
{
    [self.maskView showWithAnimationBlock:animationEngineBlock];
    return self;
}

- (void)hideWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock
{
    [self.maskView hideWithAnimationBlock:animationEngineBlock];
}

- (void)addContentView
{
    
}
- (CGSize)dialogSize
{
    return XFDialogRealValueWithType(XFDialogSize, CGSizeValue, CGSizeMake(XFDialogDefW, XFDialogDefH));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.attrs[XFDialogTitleIsMultiLine]) {
        self.titleChangeValue = 0.f;
        float spacing = XFDialogRealValueWithFloatType(XFDialogItemSpacing, XFDialogDefItemSpacing);
        self.titleLabel.x = spacing;
        self.titleLabel.y = spacing * 2;
        self.titleLabel.width = self.dialogSize.width - spacing;
        self.titleLabel.height = [self realTitleHeight] - spacing * 2;
        self.titleChangeValue = self.titleLabel.height;
    }else{
        self.titleLabel.width = self.dialogSize.width;
        self.titleLabel.height = [self realTitleHeight];
    }
}

// 获取真实标题高度
- (CGFloat)realTitleHeight
{
    // 如果没有标题
    if ([@"" isEqualToString:self.titleLabel.text] || self.titleLabel.text == nil) {
        return 0.0f;
    }
    // 是否有设置多行高度
    if (self.titleChangeValue > 0.f) {
        float spacing = XFDialogRealValueWithFloatType(XFDialogItemSpacing, XFDialogDefItemSpacing);
        return self.titleChangeValue + spacing * 2;
    }
    // 返回初始设置
    return  XFDialogRealValueWithFloatType(XFDialogTitleViewHeight, XFDialogTitleViewDefH);
}


@end
