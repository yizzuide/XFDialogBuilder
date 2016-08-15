//
//  XFTextView.m
//  XFDialogBuilder
//
//  Created by Yizzuide on 15/6/18.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFTextView.h"
// 实现占位符的另一种方法是添加一个UILabel,当实现占位符可拖动时,最好用UILabel添加到View,因为它会跟着光标拖动
@implementation XFTextView

static CGFloat y = 8;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 侦听本身文本改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
// 设置完属性就刷新
- (void)setPlaceHodler:(NSString *)placeHodler
{
    _placeHodler = [placeHodler copy];
     // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}
- (void)setPlaceHodlerColor:(UIColor *)placeHodlerColor
{
    _placeHodlerColor = placeHodlerColor;
    [self setNeedsDisplay];
}
- (void)setText:(NSString * __nullable)text{
    [super setText:text];
    [self setNeedsDisplay];
}
// 当属性文字发生改变
- (void)setAttributedText:(NSAttributedString * __nullable)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
    
    // 由于设置了AttributedText系统并不发送text改变通知,手动发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}
- (void)setFont:(UIFont * __nullable)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 如果有内容返回
    if (self.hasText) return;
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeHodlerColor ? self.placeHodlerColor:[UIColor grayColor];
    
    // 使用drawInRect可以让它换行
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeHodler drawInRect:placeholderRect withAttributes:attrs];
}

- (void)textDidChange {
    [self setNeedsDisplay];
}


- (void)scrollToY:(CGFloat)scrollY
{
    y = scrollY * 0.01 + 8;
    [self setNeedsDisplay];
}



// 这个View卸载时移除侦听
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
