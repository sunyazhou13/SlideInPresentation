//
//  SlideInPresentationManager.m
//  Nemo
//
//  Created by sunyazhou on 2017/6/9.
//  Copyright © 2017年 com.sunyazhou. All rights reserved.
//

#import "SlideInPresentationManager.h"
#import "SlideInPresentationController.h"
#import "SlideInPresentationAnimator.h"

@interface SlideInPresentationManager () 

@property (nonatomic, weak) SlideInPresentationController *sliderPresentationController; //弱引用

@end

@implementation SlideInPresentationManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.sliderRate = 1.0/3.0;
        self.showDimView = YES;
        self.containerViewSizeToFit = NO;
        self.dimBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    }
    return self;
}

- (void)dealloc
{
    self.sliderPresentationController = nil;
}

- (void)forceDismiss:(BOOL)needCallCompletionBlock
{
    if (self.sliderPresentationController) {
        if (needCallCompletionBlock) {
            [self.sliderPresentationController forceDismiss];
        } else {
            [self.sliderPresentationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark -
#pragma mark - UIViewControllerTransitioningDelegate 转场代理
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    SlideInPresentationController *presentationController = [[SlideInPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting andDirection:self.direction];
    presentationController.delegate = self;
    presentationController.sliderRate = self.sliderRate;
    presentationController.showDimView = self.showDimView;
    presentationController.containerViewSizeToFit = self.containerViewSizeToFit;
    presentationController.dismissCompletion = self.dismissCompletion;
    presentationController.dimBackgroundColor = self.dimBackgroundColor;
    self.sliderPresentationController = presentationController;
    return presentationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    return [[SlideInPresentationAnimator alloc] initWithDirection:self.direction isPresentation:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[SlideInPresentationAnimator alloc] initWithDirection:self.direction isPresentation:NO];
}



#pragma mark -
#pragma mark - UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    if (traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact && self.disableCompactHeight) {
        return UIModalPresentationFullScreen;
    }
    return UIModalPresentationNone;
}

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    if (style == UIModalPresentationFullScreen) {
        return nil;
    }
    return nil;
}

@end
