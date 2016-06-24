//
//  XFDialogTextView.m
//  CreativeButton
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 RightBrain. All rights reserved.
//

#import "XFDialogNotice.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"


const NSString *XFDialogContentText = @"XFDialogContentText";
const NSString *XFDialogContentTextColor = @"XFDialogContentTextColor";
const NSString *XFDialogContentTextFontSize = @"XFDialogContentTextFontSize";
const NSString *XFDialogContentTextAlgin = @"XFDialogContentTextAlgin";
const NSString *XFDialogContentTextLRPading = @"XFDialogContentTextLRPading";


@interface XFDialogNotice ()

@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation XFDialogNotice

- (void)addContentView
{
    [super addContentView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    NSString *text = XFDialogRealValue(XFDialogContentText, @"确定选择吗？");
    contentLabel.textColor = XFDialogRealValue(XFDialogContentTextColor, [UIColor blackColor]);
    contentLabel.textAlignment = XFDialogRealValueWithType(XFDialogContentTextAlgin, integerValue, NSTextAlignmentCenter);
    contentLabel.numberOfLines = 0;
    /*NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    [contentLabel setAttributedText:attributedString1];
    [contentLabel sizeToFit];*/
    contentLabel.text = text;
    contentLabel.font = XFDialogRealFont(XFDialogContentTextFontSize,XFDialogContentTextDefFontSize);
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self.contentLabel.text
                   boundingRectWithSize:CGSizeMake(self.dialogSize.width - XFDialogRealValueWithFloatType(XFDialogContentTextLRPading, 0.0), MAXFLOAT)
                   options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:@{
                                NSFontAttributeName :
                                    XFDialogRealFont(XFDialogContentTextFontSize, XFDialogContentTextDefFontSize)                                } context:nil].size;
    
    self.contentLabel.x = (self.width - size.width) * 0.5;
    self.contentLabel.y = (self.height - [self realTitleHeight] - [self realCommandButtonHeight] - size.height) * 0.5 + [self realTitleHeight];
    self.contentLabel.size = size;
}
@end
