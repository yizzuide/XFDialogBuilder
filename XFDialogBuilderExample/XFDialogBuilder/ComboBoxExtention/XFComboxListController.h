//
//  XFComboxListController.h
//  XFDialogBuilderExample
//
//  Created by yizzuide on 15/9/15.
//  Copyright (c) 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFDropdownMenu.h"

typedef NSString * const ConstStringRef;

extern ConstStringRef XFRegionDidSelectedNotification;
extern ConstStringRef XFRegionDidSelectedTargetView;
extern ConstStringRef XFRegionDidSelectedRow;


@interface XFComboxListController : UITableViewController <XFDropdownMenuInteractiveDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) XFDropdownMenu *dropdownMenu;
// 设置文本
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIColor *textColor;
// 设置列表框
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, strong) UIColor *cellSelectedBackgroundColor;
@end
