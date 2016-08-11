//
//  XFDropdownMenu.h
//  XFDialogBuilder
//
//  Created by Yizzuide on 15/6/10.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFDropdownMenu;

/**
 *  显示隐藏回调
 */
@protocol XFDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidShow:(XFDropdownMenu *)menu;
- (void)dropdownMenuDidDismiss:(XFDropdownMenu *)menu;

@end
/**
 *  交互的协议
 */
@protocol XFDropdownMenuInteractiveDelegate <NSObject>
@required
@property (nonatomic, weak) XFDropdownMenu *dropdownMenu;
@end

@interface XFDropdownMenu : UIView

@property (nonatomic, weak) id<XFDropdownMenuDelegate> delegate;
@property (nonatomic, weak) UIView *currentTargetView;

+ (instancetype)menuWithContentView:(UIView *)view Size:(CGSize)size BgImage:(UIImage *)bgImage;
+ (instancetype)menuWithContentControllerView:(UIViewController *)controller Size:(CGSize)size BgImage:(UIImage *)bgImage;

/**
 *  从控件下方显示菜单
 */
- (void)showFromView:(UIView *)anchorView;



/**
 *  消失
 */
- (void)dismiss;
@end
