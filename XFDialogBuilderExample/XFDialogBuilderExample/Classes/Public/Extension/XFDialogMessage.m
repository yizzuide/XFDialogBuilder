//
//  XFDialogMessage.m
//  XFDialogBuilderExample
//
//  Created by 付星 on 16/7/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDialogMessage.h"

@implementation XFDialogMessage

// 第一步： 添加子视图内容
- (void)addContentView
{
    // 调用父类实现
    [super addContentView];
    
    
}

// 第二步：返回对话框大小：父类有默认的大小，如果这个自定义对话框添加子视图，就必须自己计算整个对话框显示的大小
- (CGSize)dialogSize{
    // 获得标题高度（宽度是对话框宽度）
    CGFloat titleH = [self realTitleHeight];
    // 获得命令式按钮高度（宽度是对话框宽度）
    CGFloat confirmButtonH = [self realCommandButtonHeight];
    // 计算自己添加的视图大小
    
    return  CGSizeMake(XFDialogDefW, titleH + confirmButtonH /* + ...其它高度 */);
}

// 第三步：布局子视图
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算添加的子视图Frame
}

@end
