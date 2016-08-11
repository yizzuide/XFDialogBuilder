//
//  XFDialogAnimationUtil.h
//  XFDialogBuilder
//
//  Created by 付星 on 16/6/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFDialogBuilder.h"

@interface XFDialogAnimationUtil : NSObject

/**
 *  推入对话框动画
 *
 *  @return 动画Block
 */
+ (addAnimationEngineBlock)topToCenter;
/**
 *  退出对话框动画
 *
 *  @return 动画Block
 */
+ (addAnimationEngineBlock)centerToTop;

/**
 *  退出对话框动画
 *
 *  @param workBlock 退出前的操作
 *
 *  @return 动画Block
 */
+ (addAnimationEngineBlock)dialogDisappearAnimWithWorkBlock:(void(^)())workBlock;

@end
