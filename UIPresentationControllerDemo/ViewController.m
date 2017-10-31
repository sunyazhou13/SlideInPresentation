//
//  ViewController.m
//  UIPresentationControllerDemo
//
//  Created by sunyazhou on 2017/10/31.
//  Copyright © 2017年 www.sunyazhou.com. All rights reserved.
//

#import "ViewController.h"

#import "SlideInPresentationManager.h"
#import "PresentController.h"
@interface ViewController ()
@property (nonatomic, strong) SlideInPresentationManager *slideInTransitioningDelegate;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//四个按钮同一个响应事件 通过不同 tag 区分
- (IBAction)presentAction:(UIButton *)sender {
    PresentationDirection direction;
    if (sender.tag == 100) {
        NSLog(@"左侧弹出模态转场");
        direction = PresentationDirectionLeft;
    } else if (sender.tag == 101) {
        NSLog(@"上弹出模态转场");
        direction = PresentationDirectionTop;
    } else if (sender.tag == 102) {
        NSLog(@"右弹出模态转场");
        direction = PresentationDirectionRight;
    } else {
        NSLog(@"下弹出模态转场");
        direction = PresentationDirectionBottom;
    }
    
    self.slideInTransitioningDelegate = nil;
    //控制现实遮盖的视图转场
    self.slideInTransitioningDelegate = [[SlideInPresentationManager alloc] init];
    self.slideInTransitioningDelegate.direction = direction;
    self.slideInTransitioningDelegate.disableCompactHeight = NO;
    self.slideInTransitioningDelegate.sliderRate = 1.0/3.0;
    
    //创建控制器实例
    PresentController *presentVC = [[PresentController alloc] initWithNibName:@"PresentController" bundle:[NSBundle mainBundle]];
    presentVC.transitioningDelegate = self.slideInTransitioningDelegate;
    presentVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:presentVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
