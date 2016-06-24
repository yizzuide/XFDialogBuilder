//
//  CBDialogMaskView.m
//  CreativeButton
//
//  Created by yizzuide on 15/9/30.
//  Copyright © 2015年 RightBrain-Tech. All rights reserved.
//

#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogFrame.h"


@interface XFMaskView ()

@property (nonatomic, weak) UIWindow *frontWindow;
@property (nonatomic, assign) CGSize orginSize;
@end

@implementation XFMaskView

- (UIWindow *)frontWindow
{
    if (_frontWindow == nil) {
        self.frontWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _frontWindow;
}

+ (instancetype)dialogMaskView
{
    CGRect rect=[[UIScreen mainScreen] bounds];
    XFMaskView *dialogMaskView = [[XFMaskView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    dialogMaskView.backgroundColor = [UIColor blackColor];
    dialogMaskView.alpha = 0.29f;
    
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
    if (animationEngineBlock) {
        self.dialogView.hidden = NO;
        animationEngineBlock(self.dialogView);
    }else{
        CABasicAnimation *scaleAnima= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.delegate = self;
        [scaleAnima setDuration:0.29f];
        scaleAnima.fromValue =[NSNumber numberWithFloat:0.5];
        scaleAnima.toValue =[NSNumber numberWithFloat:1];
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
    self.dialogView.centerX = self.centerX;
    self.dialogView.centerY = self.centerY;
    [self.dialogView layoutIfNeeded];
}

- (void)hideWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock
{
    if (animationEngineBlock) {
        float duration = animationEngineBlock(self.dialogView);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dialogView removeFromSuperview];
            [self removeFromSuperview];
        });
    }else{
        [self.dialogView removeFromSuperview];
        [self removeFromSuperview];
    }
    
}

- (void)hideAction:(id)sender {
    XFDialogFrame *df = (XFDialogFrame *)self.dialogView;
    [df endEditing:YES];
    [self hideWithAnimationBlock:df.cancelAnimationEngineBlock];
}

@end