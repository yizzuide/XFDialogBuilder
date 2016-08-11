//
//  XFRightImageButton.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/14.
//  Copyright (c) 2015年 yizzuide. All rights reserved.
//

#import "XFRightImageButton.h"
#import "UIView+DialogMeasure.h"


@implementation XFRightImageButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = (self.width - self.titleLabel.width) * 0.5;
    self.imageView.x = self.width - self.imageView.width - 8;
}

@end
