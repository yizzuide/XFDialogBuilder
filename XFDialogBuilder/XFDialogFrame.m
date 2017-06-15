//
//  XFDialogFrameView.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFDialogFrame.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"
#import "XFDialogPanelView.h"

const NSString *XFDialogMaskViewBackgroundColor = @"XFDialogMaskViewBackgroundColor";
const NSString *XFDialogMaskViewAlpha = @"XFDialogMaskViewAlpha";
const NSString *XFDialogEnableBlurEffect = @"XFDialogEnableBlurEffect";
const NSString *XFDialogSize = @"XFDialogSize";
const NSString *XFDialogCornerRadius = @"XFCornerRadius";
const NSString *XFDialogBackground = @"XFDialogBackground";
const NSString *XFDialogLineColor = @"XFDialogLineColor";
const NSString *XFDialogLineWidth = @"XFDialogLineWidth";
const NSString *XFDialogLineMargin = @"XFDialogLineMargin";

const NSString *XFDialogTitleViewBackgroundColor = @"XFDialogTitleViewBackgroundColor";
const NSString *XFDialogTitleColor = @"XFDialogTitleColor";
const NSString *XFDialogTitleFontSize= @"XFDialogTitleFontSize";
const NSString *XFDialogTitleViewHeight= @"XFDialogTitleViewHeight";
const NSString *XFDialogTitleAlignment = @"XFDialogTitleAlignment";
const NSString *XFDialogTitleIsMultiLine = @"XFDialogTitleIsMultiLine";
const NSString *XFDialogMultiLineTitleMargin = @"XFDialogMultiLineTitleMargin";

@interface XFDialogFrame ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *attrs;
@property (nonatomic, weak, readwrite) UILabel *titleLabel;
@property (nonatomic, copy,readwrite) CommitClickBlock commitCallBack;
@property (nonatomic, weak, readwrite) XFMaskView *maskView;

@property (nonatomic, weak) UIView *panelView;

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

+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(CommitClickBlock)commitCallBack
{
    // 初始化对话框
    XFDialogFrame *dialogFrameView = [[self alloc] init];
    dialogFrameView.attrs = [attrs mutableCopy];
    dialogFrameView.commitCallBack = commitCallBack;
    
    dialogFrameView.layer.cornerRadius = XFDialogRealValueWithTypeForRef(attrs, XFDialogCornerRadius, floatValue, XFDialogDefCornerRadius);
    dialogFrameView.backgroundColor = XFDialogRealValueForRef(attrs, XFDialogBackground, [UIColor whiteColor]);
    
    // 添加毛玻璃层
    if(attrs[XFDialogEnableBlurEffect]){
        XFDialogPanelView *panelView = [[XFDialogPanelView alloc] init];
        panelView.backgroundColor = [UIColor whiteColor];
        panelView.size = [dialogFrameView dialogSize];
        [dialogFrameView addSubview:panelView];
        dialogFrameView.panelView = panelView;
    }
    

    
    // 添加标题
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
    
    // 添加子控件其它视图
    [dialogFrameView addContentView];
    // 设置对话框大小
    dialogFrameView.size = [dialogFrameView dialogSize];
    
    // 添加到遮盖层
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

- (instancetype)setCancelCallBack:(CancelClickBlock)cancelCallBack
{
    self.maskView.cancelCallBack = cancelCallBack;
    return self;
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
        float spacing = XFDialogRealValueWithFloatType(XFDialogMultiLineTitleMargin, XFDialogDefItemSpacing);
        self.titleLabel.x = spacing;
        self.titleLabel.y = spacing;
        self.titleLabel.width = self.dialogSize.width - spacing * 2;
        CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.titleLabel.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        self.titleLabel.height = titleSize.height;
        self.titleChangeValue = self.titleLabel.height;
    }else{
        self.titleLabel.width = self.dialogSize.width;
        self.titleLabel.height = [self realTitleHeight];
    }
    
    self.panelView.size = self.dialogSize;
}

// 获取真实标题高度
- (CGFloat)realTitleHeight
{
    // 如果没有标题
    if ([@"" isEqualToString:self.titleLabel.text] || self.titleLabel.text == nil) {
        return 0.0f;
    }
    // 计算多行文本标题高度给子对话框使用
    if (self.attrs[XFDialogTitleIsMultiLine]) {
        float spacing = XFDialogRealValueWithFloatType(XFDialogMultiLineTitleMargin, XFDialogDefItemSpacing);
        // 如果布局完成
        if (self.titleChangeValue) {
            return self.titleChangeValue + spacing;
        }else{
            // 在布局之前，只能手动再计算一次
            CGSize dialogSize = XFDialogRealValueWithType(XFDialogSize, CGSizeValue, CGSizeMake(XFDialogDefW, XFDialogDefH));
            self.titleLabel.width = dialogSize.width - spacing * 2;
            CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.titleLabel.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            return titleSize.height + spacing;
        }
        
    }
    // 返回初始设置
    return  XFDialogRealValueWithFloatType(XFDialogTitleViewHeight, XFDialogTitleViewDefH);
}


@end
