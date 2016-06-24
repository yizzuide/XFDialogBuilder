//
//  XFDropdownMenu.m
//
//
//  Created by Yizzuide on 15/6/10.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFDropdownMenu.h"
#import "UIView+DialogMeasure.h"

#define XFPaddingX 10
#define XFPaddingY 15

@interface XFDropdownMenu ()
/**
 *  控制器视图
 */
@property (nonatomic, strong) UIViewController *contentController;

@property(nonatomic ,weak) UIImageView *container;
@end

@implementation XFDropdownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置蒙版
//        self.backgroundColor = [UIColor rgbColorWithRed:123 green:123 blue:123 alpha:127];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menuWithContentView:(UIView *)view Size:(CGSize)size BgImage:(UIImage *)bgImage
{
    XFDropdownMenu *menu = [[self alloc] init];
    
    [menu setImageContainer:bgImage];
    [menu layoutContent:view size:size];

    // 蒙版视图
    return menu;
}
+ (instancetype)menuWithContentControllerView:(UIViewController *)controller Size:(CGSize)size BgImage:(UIImage *)bgImage
{
    XFDropdownMenu *menu = [[self alloc] init];
    // 必须强引用住控制器,它里面的方法才能得到响应
    menu.contentController = controller;
    
    // 如果有实现交互的协议
    if ([controller respondsToSelector:@selector(setDropdownMenu:)]) {
        id<XFDropdownMenuInteractiveDelegate> dropdownInteractive = (id<XFDropdownMenuInteractiveDelegate>)controller;
        [dropdownInteractive setDropdownMenu:menu];
    }
    
    // 设置容器
    [menu setImageContainer:bgImage];
    // 设置内容,并添加到容器
    [menu layoutContent:controller.view size:size];
    return menu;
}

- (void)setImageContainer:(UIImage *)bgImage
{
    UIImageView *imageView = [[UIImageView alloc] init];
    //imageView.size = CGSizeMake(217, 217);
    imageView.image = bgImage;
    // 使子内容可交互
    imageView.userInteractionEnabled = YES;
    
    self.container = imageView;
    
    // 添加背景图片View
    [self addSubview:imageView];
}

- (void)layoutContent:(UIView *)content size:(CGSize)size
{
    // 根据容器的padding调整内容View
    content.x = XFPaddingX;
    content.y = XFPaddingY;
    // 设置内容大小
    content.size = size;
    
    // 根据内容设置容器大小
    self.container.width = size.width + XFPaddingX * 2;
    self.container.height = size.height + XFPaddingY * 2;
    
    [self.container addSubview:content];
}


- (void)showFromView:(UIView *)anchorView
{
    self.currentTargetView = anchorView;
    // 拿到window
    // self.view.window //这个view必须加载完成并显示到window上,否则为nil
    // [UIApplication sharedApplication].keyWindow // 这个window不是最上层的,可能被键盘盖住,键盘也是一个新添加进来的上层的窗口
    // 拿到最上层的window
    UIWindow *topWindow = [[UIApplication sharedApplication].windows lastObject];
    
    // 向蒙版添加容器视图
    self.frame = topWindow.bounds;
    
    // toView设置为nil则是窗口
    // 从anchorView本身坐标系转到窗口坐标系
    CGRect frame = [anchorView convertRect:anchorView.bounds toView:nil];
    // 从父容器坐标系查看frame在全局窗口位置,和上面效果一样
//    CGRect frame = [anchorView.superview convertRect:anchorView.frame toView:nil];
    // 容器显示位置
    self.container.centerX = CGRectGetMidX(frame);
    self.container.y = CGRectGetMaxY(frame);
    // 添加到窗口
    [topWindow addSubview:self];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        [self removeFromSuperview];
    }];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(nonnull NSSet *)touches withEvent:(nullable UIEvent *)event
{
    [self dismiss];
}
@end
