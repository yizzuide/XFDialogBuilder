//
//  CBUITool.h
//  XFDialogBuilderExample
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFUITool : NSObject
/**
 *  显示消息通知
 *
 *  @param title         内容
 *  @param completeBlock 完成回调
 */
+ (void)showToastWithTitle:(NSString *)title complete:(void (^)())completeBlock;

@end
