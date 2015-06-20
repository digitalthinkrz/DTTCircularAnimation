//
//  CircularNavigationController.m
//  CircularAnimation
//
//  Created by Shaurya on 20/06/15.
//  Copyright (c) 2015 DigitalThinkrz. All rights reserved.
//

#import "CircularNavigationController.h"
#import "CircularTransitionManager.h"

@interface CircularNavigationController ()<UINavigationControllerDelegate>
@end

@implementation CircularNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.delegate = self;
    }
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    id returnObj = nil;
    switch (operation) {
        case UINavigationControllerOperationPush:
            returnObj = [[CircularTransitionManager alloc] init];
            break;
            
        default:
            break;
    }
    return returnObj;
}
@end
