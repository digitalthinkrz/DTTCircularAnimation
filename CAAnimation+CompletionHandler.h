//
//  CAAnimation+CompletionBlockHandler.h
//  CircularAnimation
//
//  Created by Shaurya on 20/06/15.
//  Copyright (c) 2015 DigitalThinkrz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (CompletionBlockHandler)
@property (nonatomic, copy) void (^completionBlockHandler)(BOOL);
- (void)setCompletionBlockHandler:(void (^)(BOOL))completionBlockHandler;
@end
