//
//  UIView+ViewRecursion.h
//  UIViewRecursion
//
//  Created by Eric Goldberg on 5/3/12.
//  Copyright (c) 2012 Eric Goldberg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SubviewBlock) (UIView* view);
typedef void (^SuperviewBlock) (UIView* superview);

@interface UIView (ViewRecursion)

-(void)runBlockOnAllSubviews:(SubviewBlock)block;
-(void)runBlockOnAllSuperviews:(SuperviewBlock)block;
-(void)enableAllControlsInViewHierarchy;
-(void)disableAllControlsInViewHierarchy;

@end
