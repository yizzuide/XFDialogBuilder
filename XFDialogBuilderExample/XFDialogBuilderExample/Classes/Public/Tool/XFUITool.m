//
//  CBUITool.m
//  XFDialogBuilderExample
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFUITool.h"
#import "MBProgressHUD.h"

#define hideDelayTime 0.5

@interface XFUITool ()

@end


@implementation XFUITool

+ (MBProgressHUD *)createHUDOnLastWindow
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    hud.labelFont = [UIFont boldSystemFontOfSize:17];
    return hud;
}

+ (void)showToastWithTitle:(NSString *)title complete:(void (^)())completeBlock
{
    MBProgressHUD *hud = [self createHUDOnLastWindow];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
    [hud show:YES];
    [hud hide:YES afterDelay:hideDelayTime];
    
    if (completeBlock) {
        hud.completionBlock = ^{
            completeBlock();
        };
    }
}



@end
