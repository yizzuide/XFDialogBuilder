//
//  ViewController.m
//  XFDialogBuilderExample
//
//  Created by yizzuide on 15/12/31.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "ViewController.h"
#import "XFDialogBuilder.h"
#import "XFComboxListController.h"
#import "XFRegion.h"
#import "XFDropdownMenu.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogMacro.h"
#import "XFDialogAnimationUtil.h"
#import "XFUITool.h"
#import "XFDialogMessage.h"


@interface ViewController ()

@property (nonatomic, weak) XFDialogFrame *dialogView;
@property (nonatomic, strong) NSArray *regions;
@property (nonatomic, strong)  NSArray<UIButton *> *selectors;
@property (nonatomic, assign) int currentProvinceID; // 省份ID
@property (nonatomic, assign) int currentCityID; // 城市ID
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.regions = [XFRegion regions];
    WS(weakSelf)
    [[NSNotificationCenter defaultCenter] addObserverForName:XFRegionDidSelectedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull noti) {
        int row = [noti.userInfo[XFRegionDidSelectedRow] intValue];
        UIButton *regionButton = noti.userInfo[XFRegionDidSelectedTargetView];
        if (regionButton.tag) { // 城市
            [weakSelf toSelectCityWithID:row];
        }else{ // 省份
            NSArray *provinces = [self.regions valueForKeyPath:@"Name"];
            NSLog(@"provinces -- %@",provinces);
            weakSelf.currentProvinceID = [weakSelf.regions[row] ID];
            [regionButton setTitle:provinces[row] forState:UIControlStateNormal];
            // 默认选中第一个城市
            [weakSelf toSelectCityWithID:0];
        }
        
    }];
}

// 根据行号选择一个城市
- (void)toSelectCityWithID:(int)cityID
{
    NSUInteger count = self.regions.count;
    for (int i = 0; i < count; i++) {
        XFRegion *region = self.regions[i];
        if (region.ID == self.currentProvinceID) {
            NSArray *cityRegions = [region valueForKeyPath:@"Children"];
            XFRegion *cityRegion = cityRegions[cityID];
            [self.selectors[1] setTitle:cityRegion.Name forState:UIControlStateNormal];
            self.currentCityID = cityRegion.ID;
        }
    }
}


- (IBAction)popupHintDialog {
    WS(weakSelf)
    self.dialogView =
    [[XFDialogNotice dialogWithTitle:@"提示"
                                  attrs:@{
                                          XFDialogMaskViewAlpha:@(0.f),
                                          // 设置毛玻璃效果时，最好把遮罩层背景去掉，标题栏背景颜色透明
                                          XFDialogEnableBlurEffect:@YES,
                                          XFDialogTitleViewBackgroundColor :UIColorFromARGB(0x00000000),
                                          XFDialogTitleColor: [UIColor blackColor],
                                          XFDialogCommitButtonCancelDisable:@YES, // 禁用取消按钮
                                          XFDialogNoticeText: @"确定退出？",
                                          }
                         commitCallBack:^(NSString *inputText) {
                             [weakSelf.dialogView hideWithAnimationBlock:nil];
                         }] showWithAnimationBlock:nil];
}

- (IBAction)popupNoTitleHintDialog:(id)sender {
    WS(weakSelf)
    self.dialogView =
    [[XFDialogNotice dialogWithTitle:nil
                                  attrs:@{
                                        XFDialogMaskViewBackgroundColor:[UIColor redColor],
                                        XFDialogMaskViewAlpha:@(0.5f),
                                        XFDialogSize:[NSValue valueWithCGSize:CGSizeMake(240, 180)],
                                        XFDialogTitleViewBackgroundColor :UIColorFromARGB(0x00000000),
                                        XFDialogTitleViewBackgroundColor : [UIColor redColor],
                                        XFDialogLineColor: [UIColor redColor],
                                        XFDialogLineWidth: @(0.5f),
                                        XFDialogCancelButtonTitle:@"否",
                                        XFDialogCommitButtonTitle:@"是",
                                        XFDialogNoticeTypeSet : @(XFDialogNoticeTypeIconWithTextVertical),
                                        //XFDialogNoticeText: @"你确定要退出吗?",
                                        XFDialogNoticeContentItemSpacing:@(20.f),
                                        XFDialogNoticeTextColor: [UIColor redColor],
                                        XFDialogNoticeIcon: [UIImage imageNamed:@"warn"],
                                        XFDialogNoticeIconSize:[NSValue valueWithCGSize:CGSizeMake(36, 36)],
                                        XFDialogCommitButtonMiddleLineDisable:@YES
                                                  }
                         commitCallBack:^(NSString *inputText) {
                             [weakSelf.dialogView hideWithAnimationBlock:[XFDialogAnimationUtil centerToTop]];
                         }] showWithAnimationBlock:[XFDialogAnimationUtil topToCenter]];
    // 使用自定义动画引擎后要设置取消动画
    self.dialogView.cancelAnimationEngineBlock = [XFDialogAnimationUtil centerToTop];
}


- (IBAction)popupOptionButtonDialog:(id)sender {
     WS(weakSelf)
    self.dialogView =
    [[XFDialogOptionButton dialogWithTitle:@"选择性别"
                                        attrs:@{
                                                XFDialogMaskViewBackgroundColor:[UIColor redColor],
                                                XFDialogMaskViewAlpha:@(0.5f),
                                              XFDialogTitleViewBackgroundColor : [UIColor redColor],
                                              XFDialogTitleColor: [UIColor whiteColor],
                                              XFDialogOptionTextList: @[@"男",@"女"]
                                              }
                               commitCallBack:^(NSString *inputText) {
                                   NSLog(@"你选择的是: %@",inputText);
                                   [XFUITool showToastWithTitle:[NSString stringWithFormat:@"你选择的是: %@",inputText] complete:nil];
                                   [weakSelf.dialogView hideWithAnimationBlock:nil];
                               }] showWithAnimationBlock:nil];
    
}

- (IBAction)popupLoginInputDialog:(id)sender {
     WS(weakSelf)
    self.dialogView =
    [[XFDialogInput dialogWithTitle:@"登录"
                                 attrs:@{
                                         XFDialogTitleViewBackgroundColor : [UIColor orangeColor],
                                         XFDialogTitleColor: [UIColor whiteColor],
                                         XFDialogLineColor: [UIColor orangeColor],
                                         XFDialogInputFields:@[
                                                 @{
                                                     XFDialogInputPlaceholderKey : @"输入用户名",
                                                     XFDialogInputTypeKey : @(UIKeyboardTypeDefault),
                                                     },
                                                 @{
                                                     XFDialogInputPlaceholderKey : @"输入新密码",
                                                     XFDialogInputTypeKey : @(UIKeyboardTypeDefault),
                                                     XFDialogInputIsPasswordKey : @(YES),
                                                     XFDialogInputPasswordEye : @{
                                                             XFDialogInputEyeOpenImage : @"ic_eye",
                                                             XFDialogInputEyeCloseImage : @"ic_eye_close"
                                                             }
                                                     },
                                                 ],
                                         XFDialogInputHintColor : [UIColor purpleColor],
                                         XFDialogInputTextColor: [UIColor orangeColor],
                                         XFDialogCommitButtonTitleColor: [UIColor orangeColor],
                                         XFDialogMultiValidatorMatchers: @[
                                                 @{
                                                     ValidatorConditionKey: ^(NSArray<UITextField *> *textfields){
        
        return textfields[0].text.length < 6;
    },ValidatorErrorKey: @"用户名小于6位！"
                                                     },
                                          @{
                                              ValidatorConditionKey: ^(NSArray<UITextField *> *textfields){
        
        return textfields[1].text.length < 6;
    },ValidatorErrorKey: @"密码小于6位！"
                                              }]
                                         }
                        commitCallBack:^(NSString *inputText) {
                            [weakSelf.dialogView hideWithAnimationBlock:nil];
                            [XFUITool showToastWithTitle:@"登录成功" complete:nil];
                        } errorCallBack:^(NSString *errorMessage) {
                            NSLog(@"error -- %@",errorMessage);
                            [XFUITool showToastWithTitle:errorMessage complete:nil];
                        }] showWithAnimationBlock:nil];
}

- (IBAction)popupUpdatePasswordDialog:(id)sender {
     WS(weakSelf)
    self.dialogView =
    [[XFDialogInput dialogWithTitle:@"修改密码"
                                 attrs:@{
                                         XFDialogTitleViewBackgroundColor : [UIColor greenColor],
                                         XFDialogTitleColor: [UIColor whiteColor],
                                         XFDialogLineColor: [UIColor greenColor],
                                         XFDialogInputFields:@[
                                                 @{
                                                     XFDialogInputPlaceholderKey : @"请输入新密码",
                                                     XFDialogInputTypeKey : @(UIKeyboardTypeDefault),
                                                     XFDialogInputIsPasswordKey : @(YES),
                                                     XFDialogInputPasswordEye : @{
                                                             XFDialogInputEyeOpenImage : @"ic_eye",
                                                             XFDialogInputEyeCloseImage : @"ic_eye_close"
                                                             }
                                                     },
                                                 @{
                                                     XFDialogInputPlaceholderKey : @"再次输入密码",
                                                     XFDialogInputTypeKey : @(UIKeyboardTypeDefault),
                                                     XFDialogInputIsPasswordKey : @(YES),
                                                     XFDialogInputPasswordEye : @{
                                                             XFDialogInputEyeOpenImage : @"ic_eye",
                                                             XFDialogInputEyeCloseImage : @"ic_eye_close"
                                                             }
                                                     },
                                                 ],
                                         XFDialogInputHintColor : [UIColor purpleColor],
                                         XFDialogInputTextColor: [UIColor greenColor],
                                         XFDialogCommitButtonTitleColor: [UIColor greenColor],
                                         XFDialogMultiValidatorMatchers: @[
                                                 @{
                                                     ValidatorConditionKey: ^(NSArray<UITextField *> *textfields){
        
        return textfields[0].text.length < 6 || textfields[1].text.length < 6;
    },ValidatorErrorKey: @"密码小于6位"
                                                     },
                                                 @{
                                                     ValidatorConditionKey: ^(NSArray<UITextField *> *textfields){
        
        return ![textfields[0].text isEqualToString:textfields[1].text];
    },ValidatorErrorKey: @"两次密码不一致！"
                                                     }]
                                         }
                        commitCallBack:^(NSString *inputText) {
                            NSLog(@"输的密码：%@",inputText);
                            [XFUITool showToastWithTitle:[NSString stringWithFormat:@"你密码的是: %@",inputText] complete:nil];
                            [weakSelf.dialogView hideWithAnimationBlock:nil];
                        } errorCallBack:^(NSString *errorMessage) {
                            NSLog(@"error -- %@",errorMessage);
                            [XFUITool showToastWithTitle:errorMessage complete:nil];
                        }] showWithAnimationBlock:nil];
    
}

- (IBAction)popupComboxDialog:(id)sender {
    self.currentProvinceID = 0;
     WS(weakSelf)
    XFDialogComboBox *comboBoxView =
    [[XFDialogComboBox dialogWithTitle:@"选择地址"
                                    attrs:@{
                                            XFDialogTitleViewBackgroundColor: [UIColor purpleColor],
                                            XFDialogTitleColor: [UIColor whiteColor],
                                            XFDialogComboBoxTitleColor : [UIColor purpleColor],
                                            XFDialogLineColor:[UIColor purpleColor],
                                            XFDialogCommitButtonTitleColor: [UIColor purpleColor],
                                            XFDialogComboBoxIcon : [UIImage imageNamed:@"ic_updown"],
                                            XFDialogComboBoxW : @(200),
                                            XFDialogComboBoxList:@[
                                                    @{  XFDialogComboBoxTitle:@"选择省份",
                                                        },
                                                    @{  XFDialogComboBoxTitle:@"选择城市",
                                                        }
                                                    ]
                                            }
                           commitCallBack:^(NSString *inputText) {
                               [weakSelf.dialogView hideWithAnimationBlock:nil];
                               [XFUITool showToastWithTitle:inputText complete:nil];
    }] showWithAnimationBlock:nil];
    
    self.selectors = comboBoxView.menuSelectors;
    NSUInteger count = self.selectors.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.selectors[i];
        button.tag = i;
        [button addTarget:self action:@selector(regionSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.dialogView = comboBoxView;
}

- (IBAction)popupTextAreaDialog:(id)sender {
    
    WS(weakSelf)
    self.dialogView =
    [[XFDialogTextArea dialogWithTitle:@"请输入你的想法吧~\n多给我们提提议建吧~"
                                 attrs:@{
                                         XFDialogTitleViewBackgroundColor : [UIColor whiteColor],
                                         XFDialogTitleColor: [UIColor blackColor],
                                         XFDialogTitleFontSize: @(14.f),
                                         XFDialogTitleAlignment: @(NSTextAlignmentLeft),
                                         XFDialogTitleIsMultiLine: @(YES),
                                         XFDialogTextAreaMargin: @(12.f),
                                         XFDialogTextAreaHeight: @(120.f),
                                         XFDialogTextAreaPlaceholderKey: @"说点什么",
                                         XFDialogTextAreaPlaceholderColorKey: [UIColor grayColor],
                                         XFDialogTextAreaHintColor: [UIColor grayColor],
                                         XFDialogLineColor: [UIColor grayColor],
                                         XFDialogTextAreaFontSize: @(15)
                                         }
                        commitCallBack:^(NSString *inputText) {
                            [weakSelf.dialogView hideWithAnimationBlock:nil];
                            [XFUITool showToastWithTitle:[NSString stringWithFormat:@"输入的内容是: %@",inputText] complete:nil];
                        }
                         errorCallBack:^(NSString *errorMessage) {
                             
                         }] showWithAnimationBlock:nil];
    [self.dialogView setCancelCallBack:^{
        NSLog(@"用户取消输入！");
    }];
}

- (addAnimationEngineBlock)dialogDisappearAnimWithWorkBlock:(void(^)())workBlock {
    if (workBlock) {
        workBlock();
    }
    return nil;
}



- (IBAction)popupCustomDialog {
     WS(weakSelf)
    self.dialogView = [[XFDialogMessage dialogWithTitle:nil attrs:@{} commitCallBack:^(NSString *inputText) {
        [weakSelf.dialogView hideWithAnimationBlock:nil];
    }] showWithAnimationBlock:nil];
    
}








- (void)regionSelectAction:(UIButton *)selector {
    XFComboxListController *regionVC = [[XFComboxListController alloc] init];
    regionVC.borderColor = [UIColor purpleColor];
    regionVC.textColor = [UIColor purpleColor];
    regionVC.textAlignment = NSTextAlignmentCenter;
    
    if (selector.tag) { // 城市
        if (self.currentProvinceID) {
            NSUInteger count = self.regions.count;
            for (int i = 0; i < count; i++) {
                XFRegion *region = self.regions[i];
                if (region.ID == self.currentProvinceID) {
                    NSArray *cityRegions = [region valueForKeyPath:@"Children"];
                    NSArray *citys = [cityRegions valueForKeyPath:@"Name"];
                    regionVC.items = citys;
                }
            }
        }else{
            NSLog(@"先选择省份！");
            [XFUITool showToastWithTitle:@"先选择省份！" complete:nil];
            return;
        }
    }else{ // 如果是省份
        regionVC.items = [self.regions valueForKeyPath:@"Name"];
    }
    [[XFDropdownMenu menuWithContentControllerView:regionVC Size:CGSizeMake(selector.width - 20, 120) BgImage:[self createImageWithColor:[UIColor whiteColor] imageSize:CGSizeMake(32, 32)]] showFromView:selector];
}

- (UIImage*)createImageWithColor:(UIColor*)color imageSize:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    theImage = [UIImage resizeTo9PitchWithUIImage:theImage];
    return theImage;
}



@end
