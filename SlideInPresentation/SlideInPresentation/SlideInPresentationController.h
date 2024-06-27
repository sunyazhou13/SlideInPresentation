//
//  SlideInPresentationController.h
//  Nemo
//
//  Created by sunyazhou on 2017/6/9.
//  Copyright © 2017年 com.sunyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideInPresentationManager.h"

@interface SlideInPresentationController : UIPresentationController

/**
 滑动展露的系数 比如 从方向是底部present出一个控制器 想让出现的控制器的高度范围是 
 屏幕的几分之几的话 ,那么这个系数就传 一个 0~1之间 比如 1/3 那么就是1.0/3.0
 
 不接受负数
 */
@property(nonatomic, assign) CGFloat sliderRate; //默认值 1.0/3.0

/**
 是否显示dim视图 默认YES
 */
@property(nonatomic, assign) BOOL showDimView;

/**
 当showDimView出现,点击黑色遮挡视图,dismiss ViewController完成回调
 */
@property (nonatomic, copy) void (^ __nullable dismissCompletion)(void);

/**
 背景容器视图是否自适应弹出的控制器视图大小 默认:NO
 */
@property (nonatomic, assign) BOOL containerViewSizeToFit;

@property (nonatomic, strong) UIColor *dimBackgroundColor; //黑色遮挡部分背景颜色

- (nonnull instancetype)initWithPresentedViewController:(nullable UIViewController *)presented
                               presentingViewController:(nullable UIViewController *)presenting
                                           andDirection:(PresentationDirection)direction;

- (void)forceDismiss;

@end
