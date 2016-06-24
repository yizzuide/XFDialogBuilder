//
//  XFRegion.h
//  XFDialogBuilderExample
//
//  Created by yizzuide on 15/9/15.
//  Copyright (c) 2015年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFRegion : NSObject <NSCoding>

@property (nonatomic, assign) unsigned int ID;
@property (nonatomic, assign) unsigned int ParentID;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, strong) NSArray *Children;

// 从plist中取得
+ (NSArray *)regions;
@end
