//
//  XFDialogTextView.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFDialogNotice.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"


const NSString *XFDialogNoticeTypeSet = @"XFDialogNoticeTypeSet";

const NSString *XFDialogNoticeIcon = @"XFDialogNoticeIcon";
const NSString *XFDialogNoticeIconSize = @"XFDialogNoticeIconSize";

const NSString *XFDialogNoticeText = @"XFDialogNoticeText";
const NSString *XFDialogNoticeTextColor = @"XFDialogNoticeTextColor";
const NSString *XFDialogNoticeTextFontSize = @"XFDialogNoticeTextFontSize";
const NSString *XFDialogNoticeTextAlgin = @"XFDialogNoticeTextAlgin";

const NSString *XFDialogNoticeContentItemSpacing = @"XFDialogNoticeContentItemSpacing";
const NSString *XFDialogNoticeContentLRPading = @"XFDialogNoticeContentLRPading";


@interface XFDialogNotice ()

@property (nonatomic, assign) XFDialogNoticeType noticeType;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *icon;
@end

@implementation XFDialogNotice

- (void)addContentView
{
    [super addContentView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    NSString *text = XFDialogRealValue(XFDialogNoticeText, @"确定选择吗？");
    contentLabel.textColor = XFDialogRealValue(XFDialogNoticeTextColor, [UIColor blackColor]);
    contentLabel.textAlignment = XFDialogRealValueWithType(XFDialogNoticeTextAlgin, integerValue, NSTextAlignmentCenter);
    contentLabel.numberOfLines = 0;
    contentLabel.text = text;
    contentLabel.font = XFDialogRealFont(XFDialogNoticeTextFontSize,XFDialogContentTextDefFontSize);
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    // 获得显示类型
    XFDialogNoticeType noticeType = XFDialogRealValueWithType(XFDialogNoticeTypeSet, integerValue, XFDialogNoticeTypePlainText);
    self.noticeType = noticeType;
    switch (noticeType) {
        case XFDialogNoticeTypePlainText: {
            break;
        }
        case XFDialogNoticeTypeIconWithTextHorizontal:
        case XFDialogNoticeTypeIconWithTextVertical: {
            UIImage *image = XFDialogRealValue(XFDialogNoticeIcon,nil);
            if (!image) {
                return;
            }
            UIImageView *icon = [[UIImageView alloc] init];
            icon.image = image;
            icon.size = XFDialogRealValueWithType(XFDialogNoticeIconSize, CGSizeValue, CGSizeMake(XFDialogNoticeIconDefSize, XFDialogNoticeIconDefSize));
            [self addSubview:icon];
            self.icon = icon;
            break;
        }
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
     CGFloat itemSpacing = XFDialogRealValueWithFloatType(XFDialogNoticeContentItemSpacing,XFDialogNoticeContentItemDefSpacing);
    CGFloat LRPadding = XFDialogRealValueWithFloatType(XFDialogNoticeContentLRPading,XFDialogNoticeContentLRDefPading);
    CGSize iconSize = XFDialogRealValueWithType(XFDialogNoticeIconSize, CGSizeValue, CGSizeMake(XFDialogNoticeIconDefSize, XFDialogNoticeIconDefSize));
    CGFloat textMaxW = 0.0;
    if (self.noticeType == XFDialogNoticeTypePlainText
        || self.noticeType == XFDialogNoticeTypeIconWithTextVertical) {
        textMaxW = self.dialogSize.width - LRPadding;
    }else if (self.noticeType == XFDialogNoticeTypeIconWithTextHorizontal){
        textMaxW = self.dialogSize.width - LRPadding - iconSize.width -  itemSpacing;
    }
    
   
    
    
    CGSize textSize;
    if (IOS7) {
        textSize = [self.contentLabel.text
                       boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT)
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{
                                    NSFontAttributeName :
                                        XFDialogRealFont(XFDialogNoticeTextFontSize, XFDialogContentTextDefFontSize)                                } context:nil].size;
    }else{
       textSize = [self.contentLabel.text sizeWithFont:XFDialogRealFont(XFDialogNoticeTextFontSize,XFDialogContentTextDefFontSize) forWidth:textMaxW lineBreakMode:NSLineBreakByClipping];
    }
    CGFloat underTitleY;
    if (self.icon && (self.noticeType == XFDialogNoticeTypeIconWithTextVertical)) {
        underTitleY = (self.height - [self realTitleHeight] - [self realCommandButtonHeight] - textSize.height - iconSize.height - itemSpacing) * 0.5 + [self realTitleHeight];
    }else{
        underTitleY = (self.height - [self realTitleHeight] - [self realCommandButtonHeight] - textSize.height) * 0.5 + [self realTitleHeight];
    }

    CGFloat textCenterX = (self.width - textSize.width) * 0.5;
    
    self.contentLabel.size = textSize;
    
    switch (self.noticeType) {
        case XFDialogNoticeTypePlainText: {
            self.contentLabel.x = textCenterX;
            self.contentLabel.y = underTitleY;
            break;
        }
        case XFDialogNoticeTypeIconWithTextHorizontal: {
            self.icon.x = (self.width - textSize.width - itemSpacing - iconSize.width) * 0.5;
            
            
            self.contentLabel.x = CGRectGetMaxX(self.icon.frame) + itemSpacing;
            self.contentLabel.y = underTitleY;
            
            self.icon.centerY = self.contentLabel.centerY;
            break;
        }
        case XFDialogNoticeTypeIconWithTextVertical: {
            self.icon.x = (self.width - self.icon.width) * 0.5;
            self.icon.y = underTitleY;
            
            self.contentLabel.x = textCenterX;
            self.contentLabel.y = CGRectGetMaxY(self.icon.frame) + itemSpacing;
            break;
        }
    }
    
    
}
@end
