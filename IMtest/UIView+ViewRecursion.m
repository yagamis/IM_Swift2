//
//  UIView+ViewRecursion.m
//  UIViewRecursion
//
//  Created by Eric Goldberg on 5/3/12.
//  Copyright (c) 2012 Eric Goldberg. All rights reserved.
//

#import "UIView+ViewRecursion.h"

@implementation UIView (ViewRecursion)

-(void)runBlockOnAllSubviews:(SubviewBlock)block
{
    block(self);
    for (UIView* view in [self subviews]) 
    {
        [view runBlockOnAllSubviews:block];
    }
}

-(void)runBlockOnAllSuperviews:(SuperviewBlock)block
{
    block(self);
    if (self.superview)
    {
        [self.superview runBlockOnAllSuperviews:block];
    }
}

-(void)enableAllControlsInViewHierarchy
{
    [self runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:YES];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:YES];
        }
    }];
}

-(void)disableAllControlsInViewHierarchy
{
    [self runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:NO];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:NO];
        }
    }];
}

@end
