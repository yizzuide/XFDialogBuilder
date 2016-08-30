//
//  XFDialogAnimationUtil.m
//  XFDialogBuilder
//
//  Created by 付星 on 16/6/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDialogAnimationUtil.h"
#import "UIView+DialogMeasure.h"
#import "POP.h"

@implementation XFDialogAnimationUtil

+ (addAnimationEngineBlock)topToCenter {
    return ^float(UIView *view) {
        
        view.y = -view.height;
        
        POPSpringAnimation *springPosY=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        springPosY.fromValue = @(0);
        springPosY.toValue= @(view.maskView.centerY);
        springPosY.springBounciness=10;
        [view.layer pop_addAnimation:springPosY forKey:@"springPosY"];
        
        return 0;
    };
}

+ (addAnimationEngineBlock)centerToTop {
    return ^float(UIView *view) {
        POPSpringAnimation *springPosY=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        springPosY.toValue= @(-view.maskView.height);
        
        springPosY.springBounciness=10;
        POPSpringAnimation *springScaleXY=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        springScaleXY.toValue=[NSValue valueWithCGPoint:CGPointMake(0.1, 0.1)];
        
        springScaleXY.springBounciness=20;
        [view.layer pop_addAnimation:springPosY forKey:@"springPosY"];
        [view.layer pop_addAnimation:springScaleXY forKey:@"springScaleXY"];
        
        return 0.5;
    };
}

@end
