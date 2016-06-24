//
//  XFRegion.m
//  XFDialogBuilderExample
//
//  Created by yizzuide on 15/9/15.
//  Copyright (c) 2015年 yizzuide. All rights reserved.
//

#import "XFRegion.h"
#import "MJExtension.h"

@implementation XFRegion

MJCodingImplementation


+ (void)initialize
{
    if (self == [XFRegion class]) {
        [XFRegion setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"Children" : [XFRegion class],
                     };
        }];
    }
}

+ (NSArray *)regions
{
    return [XFRegion objectArrayWithFilename:@"regions.plist"];
}
@end
