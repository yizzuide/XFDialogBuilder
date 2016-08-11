//
//  XFDialogPanelView.m
//  XFDialogBuilder
//
//  Created by 付星 on 16/7/14.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDialogPanelView.h"
#import "UIView+DialogMeasure.h"

CGPoint RectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect RectAroundCenter(CGPoint center, CGSize size)
{
    CGFloat halfWidth = size.width * 0.5f;
    CGFloat halfHeight = size.height * 0.5f;
    return CGRectMake(center.x - halfWidth, center.y - halfHeight, size.width, size.height);
}

@interface XFDialogPanelView ()

@property (nonatomic, weak) UIView *blurView;
@end

@implementation XFDialogPanelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self blurView];
    }
    return self;
}


- (UIView *)blurView
{
    if (_blurView == nil) {
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        toolbar.barStyle = UIBarStyleDefault;
        [self addSubview:toolbar];
        _blurView = toolbar;
    }
    return _blurView;
}

- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIImage *bgImage = [self captureScreen];
    CGRect drawingRect = RectAroundCenter(RectGetCenter(rect), bgImage.size);
    [bgImage drawInRect:drawingRect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.blurView.size = self.size;
}

@end
