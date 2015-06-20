//
//  CAAnimation+CompletionBlockHandler.m
//  CircularAnimation
//
//  Created by Shaurya on 20/06/15.
//  Copyright (c) 2015 DigitalThinkrz. All rights reserved.
//

#import "CAAnimation+CompletionHandler.h"

@interface CAAnimationCompletionDelegate : NSObject
@property (nonatomic, copy) void (^completionHandler)(BOOL completed);
@end

@implementation CAAnimationCompletionDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.completionHandler != nil)
        self.completionHandler(flag);
}
@end

@implementation CAAnimation (CompletionBlockHandler)
- (void)setCompletionBlockHandler:(void (^)(BOOL))completionBlockHandler {
    if ([self.delegate isKindOfClass:[CAAnimationCompletionDelegate class]]) {
        ((CAAnimationCompletionDelegate *)self.delegate).completionHandler = completionBlockHandler;
    } else {
        CAAnimationCompletionDelegate *delegate = [[CAAnimationCompletionDelegate alloc] init];
        delegate.completionHandler = completionBlockHandler;
        self.delegate = delegate;
    }
}

- (void (^)(BOOL))completionBlockHandler {
    return [self.delegate isKindOfClass:[CAAnimationCompletionDelegate class]]? ((CAAnimationCompletionDelegate *)self.delegate).completionHandler: nil;
}
@end