//
//  XFDialogMaskView.h
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

/**
 *  添加遮罩层
 *
 *  @param backColor 背景色
 *  @param alpha     透明度
 *
 *  @return XFMaskView
 */
+ (instancetype)dialogMaskViewWithBackColor:(UIColor *)backColor alpha:(CGFloat)alpha;
/**
 *  通过动画引擎显示,使用默认可传nil
 *
 *  @param animationEngineBlock 动画引擎Block
 */
- (void)showWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock;
/**
 *  通过动画引擎隐藏,使用默认可传nil
 *
 *  @param animationEngineBlock 动画引擎Block
 */
- (void)hideWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock;
@end
