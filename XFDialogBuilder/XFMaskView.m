//
//  XFDialogMaskView.m
//  CreativeButton
//
//  Created by yizzuide on 15/9/30.
//  Copyright © 2015年 RightBrain-Tech. All rights reserved.
//

#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogFrame.h"
#import "XFDialogMacro.h"


@interface XFMaskView ()

@property (nonatomic, weak) UIWindow *frontWindow;
@property (nonatomic, assign) CGSize orginSize;
@property (nonatomic, assign) BOOL willDisapper;
@end

@implementation XFMaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 侦听屏幕旋转
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willRotateWithNoti:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)willRotateWithNoti:(NSNotification *)noti {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height);
    }];
}

- (UIWindow *)frontWindow
{
    if (_frontWindow == nil) {
        self.frontWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _frontWindow;
}

+ (instancetype)dialogMaskViewWithBackColor:(UIColor *)backColor alpha:(CGFloat)alpha
{
    CGRect rect=[[UIScreen mainScreen] bounds];
    XFMaskView *dialogMaskView = [[XFMaskView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    dialogMaskView.backgroundColor = backColor;
    dialogMaskView.alpha = alpha;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:dialogMaskView action:@selector(hideAction:)];
    [dialogMaskView addGestureRecognizer:tapGesture];
    
    return dialogMaskView;
}

- (void)setDialogView:(UIView *)dialogView
{
    //    _dialogView = dialogView;
    
    [self.frontWindow addSubview:self];
    dialogView.centerX = self.centerX;
    dialogView.centerY = self.centerY;
    dialogView.hidden = YES;
    
    [dialogView.layer removeAllAnimations];
    
    [self.frontWindow addSubview:dialogView];
    
    _dialogView = dialogView;
    
    self.orginSize = dialogView.size;
}

- (void)showWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock
{
    self.willDisapper = NO;
    if (animationEngineBlock) {
        self.dialogView.hidden = NO;
        animationEngineBlock(self.dialogView);
    }else{
        CABasicAnimation *scaleAnima= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.delegate = self;
        [scaleAnima setDuration:0.29f];
        scaleAnima.fromValue =[NSNumber numberWithFloat:0.5];
        scaleAnima.toValue =[NSNumber numberWithFloat:1];
        scaleAnima.removedOnCompletion = NO;
        scaleAnima.fillMode = kCAFillModeForwards;
        //    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.584 : 0.070 : 0.201 : 0.965];
        CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.000 : 0.292 : 0.132 : 0.896];
        [scaleAnima setTimingFunction:timingFunction];
        
        [self.dialogView.layer addAnimation:scaleAnima forKey:@"scale"];
        self.dialogView.centerX = self.centerX;
        self.dialogView.centerY = self.centerY;
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    self.dialogView.hidden = NO;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.willDisapper) {
        [self.dialogView.layer removeAllAnimations];
        [self.dialogView removeFromSuperview];
        [self removeFromSuperview];
    }else{
        self.dialogView.centerX = self.centerX;
        self.dialogView.centerY = self.centerY;
        [self.dialogView layoutIfNeeded];
    }
}

- (void)hideWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock
{
    self.willDisapper = YES;
    if (animationEngineBlock) {
        float duration = animationEngineBlock(self.dialogView);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dialogView.layer removeAllAnimations];
            [self.dialogView removeFromSuperview];
            [self removeFromSuperview];
        });
    }else{
        CABasicAnimation *scaleAnima= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.delegate = self;
        [scaleAnima setDuration:0.2f];
        scaleAnima.fromValue =[NSNumber numberWithFloat:1.0];
        scaleAnima.toValue =[NSNumber numberWithFloat:0.0];
        scaleAnima.removedOnCompletion = NO;
        scaleAnima.fillMode = kCAFillModeForwards;
        CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.389 : 0.000 : 0.222 : 1.000];
        [scaleAnima setTimingFunction:timingFunction];
        
        [self.dialogView.layer addAnimation:scaleAnima forKey:@"scale"];
        
        CABasicAnimation *alphaAnima= [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnima.delegate = self;
        [alphaAnima setDuration:0.2f];
        alphaAnima.fromValue =[NSNumber numberWithFloat:1.0];
        alphaAnima.toValue =[NSNumber numberWithFloat:0.0];
        alphaAnima.removedOnCompletion = NO;
        alphaAnima.fillMode = kCAFillModeForwards;
        
        [self.dialogView.layer addAnimation:alphaAnima forKey:@"opacity"];
    }
    
}

- (void)hideAction:(id)sender {
    XFDialogFrame *df = (XFDialogFrame *)self.dialogView;
    [df endEditing:YES];
    [self hideWithAnimationBlock:df.cancelAnimationEngineBlock];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 重新布局对话框视图
    self.dialogView.centerX = self.centerX;
    self.dialogView.centerY = self.centerY;
    [self.dialogView layoutIfNeeded];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
