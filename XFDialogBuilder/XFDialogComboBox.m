//
//  XFComboBoxView.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFDialogComboBox.h"
#import "XFRightImageButton.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"


const NSString *XFDialogComboBoxIcon = @"XFDialogComboBoxIcon";
const NSString *XFDialogComboBoxTitleColor = @"XFDialogComboBoxTitleColor";
const NSString *XFDialogComboBoxW = @"XFDialogComboBoxW";
const NSString *XFDialogComboBoxH = @"XFDialogComboBoxH";
const NSString *XFDialogComboBoxMargin = @"XFDialogComboBoxMargin";
const NSString *XFDialogComboBoxFontSize = @"XFDialogComboBoxFontSize";

/**
 *  @[@{
    @"XFDialogComboBoxTitle":@"选择省份,
    @"XFDialogComboBoxDataSource":@[]
 },@{}]
 */
const NSString *XFDialogComboBoxList = @"XFDialogComboBoxList";
const NSString *XFDialogComboBoxTitle = @"XFDialogComboBoxTitle";

@interface XFDialogComboBox ()
@end

@implementation XFDialogComboBox

- (NSMutableArray<UIButton *> *)menuSelectors
{
    if (_menuSelectors == nil) {
        NSMutableArray<UIButton *> *menuSelectors = [NSMutableArray array];
        _menuSelectors = menuSelectors;
    }
    return _menuSelectors;
}

- (void)addContentView
{
    [super addContentView];
    
    // 添加下拉列表
    NSArray *comboBoxs = self.attrs[XFDialogComboBoxList];
    NSUInteger count =  comboBoxs.count;
    for (int i = 0; i < count; i++) {
        XFRightImageButton *menuSelector = [[XFRightImageButton alloc] init];
        menuSelector.layer.borderColor = XFDialogRealValueWithType(XFDialogLineColor, CGColor, [UIColor grayColor].CGColor);
        menuSelector.layer.borderWidth = XFDialogRealValueWithFloatType(XFDialogLineWidth, XFDialogLineDefW);
        menuSelector.size = CGSizeMake(XFDialogRealValueWithFloatType(XFDialogComboBoxW, XFDialogComboBoxDefW), XFDialogRealValueWithFloatType(XFDialogComboBoxH, XFDialogComboBoxDefH));
        
        if (self.attrs[XFDialogComboBoxIcon]) {
            [menuSelector setImage:self.attrs[XFDialogComboBoxIcon] forState:UIControlStateNormal];
        }
        [menuSelector setTitle: XFDialogRealValueForRef(self.attrs[XFDialogComboBoxList][i], XFDialogComboBoxTitle, @"请选择...") forState:UIControlStateNormal];
        [menuSelector setTitleColor:XFDialogRealValue(XFDialogComboBoxTitleColor, [UIColor blackColor]) forState:UIControlStateNormal];
        
        menuSelector.titleLabel.font = XFDialogRealFont(XFDialogComboBoxFontSize, XFDialogComboBoxDefFontSize);
        
        [self addSubview:menuSelector];
        __weak XFRightImageButton *weakSelector = menuSelector;
        [self.menuSelectors addObject:weakSelector];
    }
}

- (CGSize)dialogSize
{
    return CGSizeMake(XFDialogDefW, [self realTitleHeight] + [self realCommandButtonHeight] + [self.attrs[XFDialogComboBoxList] count] * XFDialogRealValueWithFloatType(XFDialogComboBoxH, XFDialogComboBoxDefH) + ([self.attrs[XFDialogComboBoxList] count] + 1) * XFDialogRealValueWithFloatType(XFDialogComboBoxMargin, XFDialogComboBoxDefMargin));
}

// 返回输入内容
- (id)inputData
{    
    return self.menuSelectors[self.menuSelectors.count -1].titleLabel.text;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    NSUInteger selectorCount = self.menuSelectors.count;
    NSUInteger currentSelectorIndex = 0;
    CGFloat titleMaxY = CGRectGetMaxY(self.titleLabel.frame);
    for (int i = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        for (int i = 0; i < selectorCount; i++) {
            UIView *selector = self.menuSelectors[i];
            if (view == selector) {
                view.x = (self.width - view.width) * 0.5;
                view.y = (currentSelectorIndex + 1) * XFDialogRealValueWithFloatType(XFDialogComboBoxMargin, XFDialogComboBoxDefMargin) + currentSelectorIndex++ * view.height + titleMaxY;
                break;
            }
        }
        
    }
    
}

@end
