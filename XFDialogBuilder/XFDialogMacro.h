//
//  XFDialogMacro.h
//  XFDialogBuilderExample
//
//  Created by yizzuide on 16/1/1.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFDialogMacro_h
#define XFDialogMacro_h

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
