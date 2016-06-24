//
//  CBDialogMaskView.h
//  CreativeButton
//
//  Created by yizzuide on 15/9/30.
//  Copyright © 2015年 RightBrain-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  动画执行代码
 *
 *  @param view 执行动画的视图
 *
 *  @return 动画执行时间
 */
typedef float(^addAnimationEngineBlock)(UIView *view);

@interface XFMaskView : UIView

@property (nonatomic, weak) UIView *dialogView;

+ (instancetype)dialogMaskView;

- (void)showWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock;
- (void)hideWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock;
@end
