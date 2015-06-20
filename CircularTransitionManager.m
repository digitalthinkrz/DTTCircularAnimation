//
//  CircularTransitionManager.m
//  CircularAnimation
//
//  Created by Shaurya on 20/06/15.
//  Copyright (c) 2015 DigitalThinkrz. All rights reserved.
//

#import "CircularTransitionManager.h"
#import "CAAnimation+CompletionHandler.h"

@implementation CircularTransitionManager

#define kAnimationDuration 1.15f

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 2.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC    = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // Get the container view - where the animation has to happen
    UIView *containerView       = [transitionContext containerView];
    
    // Set up the shape of the circle.
    CGFloat maskCircleDiameter  = sqrtf(powf(CGRectGetWidth(fromVC.view.bounds), 2) + powf(CGRectGetHeight(fromVC.view.bounds), 2));
    
    // Make a circular shape layer.
    CAShapeLayer *maskCircularLayer = [CAShapeLayer layer];
    maskCircularLayer.path          = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, maskCircleDiameter, maskCircleDiameter) cornerRadius:maskCircleDiameter/2.0f].CGPath;
        // Center the shape in the view.
    maskCircularLayer.position      = CGPointMake((CGRectGetWidth(fromVC.view.bounds) - maskCircleDiameter)/2, (CGRectGetHeight(fromVC.view.bounds) - maskCircleDiameter)/2);
    
    // Animation
    CABasicAnimation *circularAnimation     = [CABasicAnimation animationWithKeyPath:@"path"];
    circularAnimation.duration              = kAnimationDuration;
    circularAnimation.fillMode              = kCAFillModeBoth;
    circularAnimation.toValue               = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:CGRectMake(maskCircleDiameter/2.0f, maskCircleDiameter/2.0f, 0.0f, 0.0f) cornerRadius:0.0f].CGPath;
    circularAnimation.fromValue             = (id)maskCircularLayer.path;
    fromVC.view.layer.mask                  = (CALayer *)maskCircularLayer;
    circularAnimation.removedOnCompletion   = NO;
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    [circularAnimation setCompletionBlockHandler:^(BOOL isCompleted) {
        fromVC.view.layer.mask = toVC.view.layer.mask = nil;
        [transitionContext completeTransition:YES];
    }];
    
    // Start the animaiton.
    [maskCircularLayer addAnimation:circularAnimation forKey:@"path"];
}

@end