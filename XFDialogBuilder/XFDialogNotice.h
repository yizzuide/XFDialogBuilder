//
//  XFDialogTextView.h
//  CreativeButton
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 RightBrain. All rights reserved.
//

#import "XFDialogCommandButton.h"

#define XFDialogContentTextDefFontSize 15.f
#define XFDialogNoticeIconDefSize 32.f
#define XFDialogNoticeContentLRDefPading 12.f
#define XFDialogNoticeContentItemDefSpacing 8.f

typedef NS_ENUM(NSInteger, XFDialogNoticeType)
{
    XFDialogNoticeTypePlainText,
    XFDialogNoticeTypeIconWithTextHorizontal,
    XFDialogNoticeTypeIconWithTextVertical,
};

extern const NSString *XFDialogNoticeTypeSet;

extern const NSString *XFDialogNoticeIcon;
extern const NSString *XFDialogNoticeIconSize;

extern const NSString *XFDialogNoticeText;
extern const NSString *XFDialogNoticeTextColor;
extern const NSString *XFDialogNoticeTextFontSize;
extern const NSString *XFDialogNoticeTextAlgin;
/**
 *  文字图片间距
 */
extern const NSString *XFDialogNoticeContentItemSpacing;
/**
 *  内容左右的Pading
 */
extern const NSString *XFDialogNoticeContentLRPading;

@interface XFDialogNotice : XFDialogCommandButton

@end
