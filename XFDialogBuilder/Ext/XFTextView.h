//
//  XFTextView.h
//  XFDialogBuilder
//
//  Created by Yizzuide on 15/6/18.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XFTextView : UITextView
/** 设置占位文本 */
@property (nonatomic, copy) NSString *placeHodler;
/** 设置占位文本颜色 */
@property (nonatomic, strong) UIColor *placeHodlerColor;

/**
 *  当拖动要让占位符也拖动:
 * 1.设置垂直方向总是可以拖动的
     textView.alwaysBounceVertical = YES;
 * 2. 实现代理方法
 - (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView
 {
    [self.textView scrollToY: -(scrollView.contentOffset.y + 64)];
 }
 *  @param y
 */
- (void)scrollToY:(CGFloat)y;
@end
