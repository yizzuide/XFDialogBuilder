//
//  XFDialogMacro.h
//  XFDialogBuilderExample
//
//  Created by yizzuide on 16/1/1.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFDialogMacro_h
#define XFDialogMacro_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define IOSVerMaxAt(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= (version))
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenSize [UIScreen mainScreen].bounds.size
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromARGB(argbValue) [UIColor colorWithRed:((float)((argbValue & 0xFF0000) >> 16))/255.0 green:((float)((argbValue & 0xFF00) >> 8))/255.0 blue:((float)(argbValue & 0xFF))/255.0 alpha:((float)((argbValue & 0xFF000000) >> 24))/255.0]

// 快速设置实际类型值
#define XFDialogRealValueWithTypeForRef(pointer,constantKey,keyValueType,defValue) (pointer[constantKey] ? [pointer[constantKey] keyValueType] : defValue)
// 快速设置实际值
#define XFDialogRealValueForRef(pointer,constantKey,defValue) (pointer[constantKey] ?: defValue)
// 快速设置字体
#define XFDialogRealFontForRef(pointer,constantKey,defValue) (pointer[constantKey] ? [UIFont  systemFontOfSize:[pointer[constantKey] floatValue]] : [UIFont systemFontOfSize:defValue])


// 快速设置实际类型值
#define XFDialogRealValueWithType(constantKey,keyValueType,defValue) (self.attrs[constantKey] ? [self.attrs[constantKey] keyValueType] : defValue)
// 快速设置实际float值
#define XFDialogRealValueWithFloatType(constantKey,defValue) (self.attrs[constantKey] ? [self.attrs[constantKey] floatValue] : defValue)
// 快速设置实际值
#define XFDialogRealValue(constantKey,defValue) (self.attrs[constantKey] ?: defValue)

// 快速设置字体
#define XFDialogRealFont(constantKey,defValue) (self.attrs[constantKey] ? [UIFont  systemFontOfSize:[self.attrs[constantKey] floatValue]] : [UIFont systemFontOfSize:defValue])


#endif /* XFDialogMacro_h */
