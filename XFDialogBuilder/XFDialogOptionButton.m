//
//  XFOptionButtonView.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFDialogOptionButton.h"
#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"

const NSString *XFDialogOptionTextList = @"XFDialogOptionTextList";
const NSString *XFDialogOptionImageList = @"XFDialogOptionImageList";
const NSString *XFDialogOptionButtonMarginBetweenContent = @"XFDialogOptionButtonMarginBetweenContent";
const NSString *XFDialogOptionTextColor = @"XFDialogOptionTextColor";
const NSString *XFDialogOptionCancelTextColor = @"XFDialogOptionCancelTextColor";
const NSString *XFDialogOptionCancelDisable = @"XFDialogOptionCancelDisable";
const NSString *XFDialogOptionButtonHeight = @"XFDialogOptionButtonHeight";
const NSString *XFDialogOptionButtonFontSize = @"XFDialogOptionButtonFontSize";



@interface XFDialogOptionButton ()

@property (nonatomic, strong) NSMutableArray<UIView *> *lines;
@end

@implementation XFDialogOptionButton

- (UIView *)createMiddleLine
{
    UIView *lineView = [[UIView alloc] init];
    lineView.height = XFDialogRealValueWithFloatType(XFDialogLineWidth, XFDialogLineDefW);
    lineView.width = self.width;
    lineView.backgroundColor = XFDialogRealValue(XFDialogLineColor, [UIColor grayColor]);
    [self addSubview:lineView];
    __weak UIView *weakLineView = lineView;
    [self.lines addObject:weakLineView];
    return lineView;
}

- (void)addContentView
{
    [super addContentView];
    
    // 可选按钮
    NSUInteger count = [self.attrs[XFDialogOptionTextList] count];
    NSArray *imageList = XFDialogRealValue(XFDialogOptionImageList, [[NSArray alloc] init]);
    for (int i = 0; i < count; i++) {
        UIButton *optionButton = [[UIButton alloc] init];
        [optionButton setTitle:self.attrs[XFDialogOptionTextList][i] forState:UIControlStateNormal];
        [optionButton setTitleColor:XFDialogRealValue(XFDialogOptionTextColor, [UIColor blackColor]) forState:UIControlStateNormal];
        optionButton.titleLabel.font = XFDialogRealFont(XFDialogOptionButtonFontSize, XFDialogOptionButtonDefFontSize);
        [self addSubview:optionButton];
        [optionButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
        if (imageList.count) {
            [optionButton setImage:[UIImage imageNamed:imageList[i]] forState:UIControlStateNormal];
            CGFloat margin = XFDialogRealValueWithFloatType(XFDialogOptionButtonMarginBetweenContent, 25);
            optionButton.titleEdgeInsets = UIEdgeInsetsMake(0, margin * 0.5, 0, 0);
            optionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, margin * 0.5);
        }
    }
    BOOL disableCancel = XFDialogRealValueWithType(XFDialogOptionCancelDisable, boolValue, NO);
    if (disableCancel) {
        return;
    }
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:XFDialogRealValue(XFDialogOptionCancelTextColor, [UIColor redColor]) forState:UIControlStateNormal];
    [self addSubview:cancelButton];
    cancelButton.titleLabel.font = XFDialogRealFont(XFDialogOptionButtonFontSize, XFDialogOptionButtonDefFontSize);
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 清空线条
    [self.lines makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.lines removeAllObjects];
    
//    LogError(@"layout optionView");
    CGFloat lineMargin = XFDialogRealValueWithType(XFDialogLineMargin, floatValue, 0);
    BOOL disableCancel = XFDialogRealValueWithType(XFDialogOptionCancelDisable, boolValue, NO);
    NSInteger lineCount = disableCancel ? [self.attrs[XFDialogOptionTextList] count] - 1 : [self.attrs[XFDialogOptionTextList] count];
    NSUInteger count = self.subviews.count;
    CGFloat buttonCount = 0;
    for (int i = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[UIButton class]]) {
            view.width = self.dialogSize.width;
            view.height = XFDialogRealValueWithFloatType(XFDialogOptionButtonHeight, XFDialogOptionButtonDefHeight);
            view.y = buttonCount++ * view.height + [self realTitleHeight];
            // 在没有超过OptionButton个数的情况下添加线条
            if (buttonCount <= lineCount) {
                UIView *lineView = [self createMiddleLine];
                lineView.x = lineMargin;
                lineView.width = self.dialogSize.width - lineMargin * 2;
                lineView.y = CGRectGetMaxY(view.frame);
            }
        }
    }
}

- (CGSize)dialogSize
{
    BOOL disableCancel = XFDialogRealValueWithType(XFDialogOptionCancelDisable, boolValue, NO);
    NSInteger hasCancel = disableCancel ? 0 : 1;
    return CGSizeMake(XFDialogDefW, [self realTitleHeight] + ([self.attrs[XFDialogOptionTextList] count] + hasCancel) * XFDialogRealValueWithFloatType(XFDialogOptionButtonHeight, XFDialogOptionButtonDefHeight) + ([self.attrs[XFDialogOptionTextList] count] - 1) * XFDialogCommandButtonLineDefH);
}

- (void)cancelAction:(id)sender {
    [self.maskView hideWithAnimationBlock:self.cancelAnimationEngineBlock];
}

- (void)commitAction:(UIButton *)optionButton {
    if (self.commitCallBack) {
        self.commitCallBack(optionButton.titleLabel.text);
        [self cancelAction:nil];
    }
}

@end
