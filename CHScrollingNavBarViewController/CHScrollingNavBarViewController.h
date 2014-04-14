//
//  CHScrollingNavBarViewController.h
//  ScrollingNavBar
//
//  Created by Chris Hetem on 4/14/14.
//  Copyright (c) 2014 croberth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHScrollingNavBarViewController : UIViewController <UIScrollViewDelegate>
/* 
 @property - animationDuration
 This property is used if a scrolling
 action doesn’t completely show or hide the navigation bar.
 Upon release of a touch event, the navigation bar will show or hide
 depending on its location with an animation duration of this property's value.
 This property must be set after callng initNavBarScrollingForScrollView
 If not value is set, default is 0.5 seconds.
 */
@property (assign, nonatomic) CGFloat animationDuration;

/*
 initNavBarScrollingForScrollView
 This function is used for the initial set up. Call this method and pass in
 the scroll view that you want the navigation bar to scroll along with.
 A navigation bar tint color must be set prior to calling this method.
 */
-(void)initNavBarScrollingForScrollView:(UIScrollView *)scrollableView;

/*
 startNavBarScrolling
 This function is used to start the scrolling action of the
 navigation bar. This should be called within the
 scrollViewWillBeginDragging delegate method of the scrollview
 you want to follow. Simply pass in your scroll view
 */
-(void)startNavBarScrolling:(UIScrollView *)scrollableView;

/*
 followScrollViewScrolling
 This function does most of the work. Call this function in your
 scrollViewDidScroll delegate method of the scroll view. It will move
 the navigation bar according to the distance you scrolled.
 */
-(void)followScrollViewScrolling:(UIScrollView *)scrollView;

/*
 endScrollViewScrolling
 This function ends each instance of a scrolling action. Call this method in your
 scrollViewDidEndDragging delegate method of the scroll view. If the navigation bar
 isn't completely showing or hiding (depending on which direction you are scrolling),
 it will ensure that the navigation bar is completely showing or hiding. It will animate
 the navigation bar to its proper location with an animation based off of the
 animationDuration property
 */
-(void)endScrollViewScrolling:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
