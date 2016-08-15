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

@property (nonatomic, assign) BOOL hasShowing;
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
    if (self.hasShowing) {
        NSInteger count = keyWindow.subviews.count;
        // count - 1 是self.dailogView  count -2 是self
        UIView *controllerView = keyWindow.subviews[count - 3];
        [controllerView.layer renderInContext:context];
    }else{
        [keyWindow.layer renderInContext:context];
    }
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
    
    self.hasShowing = YES;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.blurView.size =  self.size;
    // 重新截屏
    [self setNeedsDisplay];
}

@end
