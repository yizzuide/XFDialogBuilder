//
//  XFComboxListController.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/15.
//  Copyright (c) 2015年 yizzuide. All rights reserved.
//

#import "XFComboxListController.h"

ConstStringRef XFRegionDidSelectedNotification = @"XFRegionDidSelectedNotification";
ConstStringRef XFRegionDidSelectedTargetView = @"XFRegionDidSelectedTargetView";
ConstStringRef XFRegionDidSelectedRow = @"XFRegionDidSelectedRow";

@interface XFComboxListController ()

@end

@implementation XFComboxListController

static NSString *identifier = @"combox-item";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.borderColor) {
        self.view.layer.borderWidth = 1;
        self.view.layer.borderColor = self.borderColor.CGColor;
        self.view.layer.masksToBounds = YES;
    }
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = self.textFont ?: [UIFont systemFontOfSize:15];
        
        cell.textLabel.textAlignment = self.textAlignment;
        cell.textLabel.textColor = self.textColor ?: [UIColor grayColor];
        cell.backgroundColor = self.cellBackgroundColor ?: [UIColor whiteColor];
        if (self.cellSelectedBackgroundColor) {
            UIView *backView = [[UIView alloc] init];
            backView.backgroundColor = self.cellSelectedBackgroundColor;
            cell.selectedBackgroundView = backView;
        }
    }
    cell.textLabel.text = self.items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:XFRegionDidSelectedNotification object:nil userInfo:@{XFRegionDidSelectedTargetView:self.dropdownMenu.currentTargetView, XFRegionDidSelectedRow:@(indexPath.row)}];
    
    [self.dropdownMenu dismiss];
    
}




@end
