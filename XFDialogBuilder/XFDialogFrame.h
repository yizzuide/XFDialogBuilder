//
//  XFDialogFrameView.h
//  CreativeButton
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 RightBrain. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  动画执行代码
 *
 *  @param view 执行动画的视图
 *
 *  @return 动画执行时间
 */
typedef float(^addAnimationEngineBlock)(UIView *view);

#define XFDialogMaskViewDefAlpha 0.29f
#define XFDialogDefW 260
#define XFDialogDefH 180
#define XFDialogTitleViewDefH 49
#define XFDialogDefCornerRadius 5
#define XFDialogTitleDefFontSize 17.f
#define XFDialogDefItemSpacing 8.f
#define XFDialogLineDefW 1.f

// 注意：以下属性都有默认设置
/** 遮罩层背景色 UIColor类型*/
extern const NSString *XFDialogMaskViewBackgroundColor;
/** 遮罩层透明度 float类型*/
extern const NSString *XFDialogMaskViewAlpha;
/** 对话框大小 CGSize类型*/
extern const NSString *XFDialogSize; // 如果不设置，会根据当前对话框类型自己计算
/** 对话框圆角 float类型*/
extern const NSString *XFDialogCornerRadius;
/** 对话框背景色 UIColor类型*/
extern const NSString *XFDialogBackground;
/** 对话框线条颜色 UIColor类型*/
extern const NSString *XFDialogLineColor;
/** 对话框线条宽度 float类型*/
extern const NSString *XFDialogLineWidth;
/** 对话框子内容的间隔 float类型*/
extern const NSString *XFDialogItemSpacing;
/** 对话框标题背景色 UIColor类型*/
extern const NSString *XFDialogTitleViewBackgroundColor;
/** 对话框标题颜色 UIColor类型*/
extern const NSString *XFDialogTitleColor;
/** 对话框标题字体大小 float类型*/
extern const NSString *XFDialogTitleFontSize;
/** 对话框标题高度 float类型*/
extern const NSString *XFDialogTitleViewHeight;
/** 对话框标题对齐方式 枚举NSTextAlignment类型*/
extern const NSString *XFDialogTitleAlignment;
/** 对话框标题是否为多行 BOOL类型*/
extern const NSString *XFDialogTitleIsMultiLine;

/**
 *  确定事件的回调
 *
 *  @param inputText 确定内容
 */
typedef void(^commitClickBlock)(NSString *inputText);


@class XFMaskView;
@interface XFDialogFrame : UIView

// 下面的不用直接赋值，使用类方法
@property (nonatomic, strong, readonly) NSDictionary *attrs;
@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, copy, readonly) commitClickBlock commitCallBack;

/**
 *  设置取消事件的动画效果（只有在自定义动画时要设置）
 */
@property (nonatomic, copy) addAnimationEngineBlock cancelAnimationEngineBlock;

/** 
 获得显示加载视图
 */
@property (nonatomic, weak, readonly) XFMaskView *maskView;

/**
 *  添加子视图
 */
- (void)addContentView;
/**
 *  对话框大小
 *
 *  @return Size
 */
- (CGSize)dialogSize;
/**
 *  获得实际标题高度
 *
 */
- (CGFloat)realTitleHeight;
/**
 *  构建对话框
 *
 *  @param title          标题
 *  @param attrs          对话框属性
 *  @param commitCallBack 确定输入内容的回调
 *
 */
+ (instancetype)dialogWithTitle:(NSString *)title attrs:(NSDictionary *)attrs commitCallBack:(commitClickBlock)commitCallBack;
/**
 *  通过动画引擎显示,使用默认可传nil
 *
 *  @param animationEngineBlock 动画执行Block，如果为空则为默认效果
 */
- (instancetype)showWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock;
/**
 *  通过动画引擎隐藏,使用默认可传nil
 *  @param animationEngineBlock 动画执行Block，如果为空则为默认效果
 */
- (void)hideWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock;
@end
