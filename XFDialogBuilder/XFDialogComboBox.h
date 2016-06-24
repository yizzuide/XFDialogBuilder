//
//  XFComboBoxView.h
//  CreativeButton
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 RightBrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFDialogFrame.h"
#import "XFDialogCommandButton.h"
#define XFDialogComboBoxDefMargin 15
#define XFDialogComboBoxDefW 125
#define XFDialogComboBoxDefH 44
#define XFDialogComboBoxDefFontSize 15

extern const NSString *XFDialogComboBoxIcon;
extern const NSString *XFDialogComboBoxTitleColor;
extern const NSString *XFDialogComboBoxW;
extern const NSString *XFDialogComboBoxH;
extern const NSString *XFDialogComboBoxMargin;
extern const NSString *XFDialogComboBoxFontSize;
/**
 *  @[@{
 @"XFDialogComboBoxTitle":@"选择省份,
 @"XFDialogComboBoxDataSource":@[]
 },@{}]
 */
extern const NSString *XFDialogComboBoxList;
extern const NSString *XFDialogComboBoxTitle;

@interface XFDialogComboBox : XFDialogCommandButton

@property (nonatomic, strong) NSMutableArray<UIButton *> *menuSelectors;
@end
