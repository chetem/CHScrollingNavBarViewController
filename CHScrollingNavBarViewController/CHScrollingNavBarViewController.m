//
//  CHScrollingNavBarViewController.m
//  ScrollingNavBar
//
//  Created by Chris Hetem on 4/14/14.
//  Copyright (c) 2014 croberth. All rights reserved.
//

#import "CHScrollingNavBarViewController.h"

@interface CHScrollingNavBarViewController ()
#define ANIMATION_DURATION_DEFAULT 0.5

@property (strong, nonatomic)UIView *overlayView;
@property (strong, nonatomic) UIScrollView *scrollableView;
@property (assign, nonatomic) CGFloat lastScrollViewOffset, startScrollViewOffset;

typedef enum ScrollDirection {
    ScrollDirectionUp,
    ScrollDirectionDown
} ScrollDirection;

- (CGFloat)verticalOffsetForBottom:(UIScrollView *)scrollView;

@end

@implementation CHScrollingNavBarViewController

-(void)initNavBarScrollingForScrollView:(UIScrollView *)scrollableView
{
	
	CGRect frame = self.navigationController.navigationBar.frame;
	frame.origin = CGPointZero;
	self.overlayView = [[UIView alloc] initWithFrame:frame];
	if (!self.navigationController.navigationBar.barTintColor) {
		NSLog(@"[%s]: %@", __func__, @"Warning: no bar tint color set");
	}
	[self.overlayView setBackgroundColor:self.navigationController.navigationBar.barTintColor];
	[self.overlayView setUserInteractionEnabled:NO];
	[self.overlayView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	[self.navigationController.navigationBar addSubview:self.overlayView];
	[self.overlayView setAlpha:0];
	self.scrollableView = scrollableView;
	[self.scrollableView setDelegate:self];
	
	self.animationDuration = ANIMATION_DURATION_DEFAULT;
}


- (void)startNavBarScrolling:(UIScrollView *)scrollableView
{
	self.lastScrollViewOffset = self.startScrollViewOffset = scrollableView.contentOffset.y;
}

- (void)followScrollViewScrolling:(UIScrollView *)scrollView
{
	
	//slide navbar up/down
	BOOL wasAnimated = NO;
	BOOL isAtBottom = NO;
	CGFloat currentOffset = scrollView.contentOffset.y;
	ScrollDirection scrollDirection = ScrollDirectionDown;
	CGFloat differenceFromLast = currentOffset - self.lastScrollViewOffset;
	CGFloat scrollViewBottomOffset = [self verticalOffsetForBottom:scrollView];
	CGFloat topThreshold = -64;
	
	NSLog(@"overlay frame %@", NSStringFromCGRect(self.overlayView.frame));
	NSLog(@"navbar frame %@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
	
	//get scroll direction
	if(self.lastScrollViewOffset > currentOffset){
		scrollDirection = ScrollDirectionUp;
	}else{
		scrollDirection = ScrollDirectionDown;
	}
	
	//check if at bottom of scroll view
	if(currentOffset >= scrollViewBottomOffset) isAtBottom = YES;
	
	//scrolling down, hide navbar
	if(scrollDirection == ScrollDirectionDown){
		
		//if scroll view is pulling past origin
		//make sure toolbar is showing
		if(currentOffset <= topThreshold){
			self.navigationController.navigationBar.frame = CGRectMake(0.0, 20.0,
																	   self.navigationController.navigationBar.frame.size.width,
																	   self.navigationController.navigationBar.frame.size.height);
			self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
												0.0,
												self.overlayView.frame.size.width,
												self.navigationController.navigationBar.frame.size.height);
			self.overlayView.alpha = 0.0;
			wasAnimated = YES;
			
			//hide nav bar
		}else if(self.navigationController.navigationBar.frame.origin.y > -24.0
				 && isAtBottom == NO && (self.navigationController.navigationBar.frame.origin.y - differenceFromLast) >= -24.0){
			CGRect navFrame = self.navigationController.navigationBar.frame;
			CGRect overlayFrame = self.overlayView.frame;
			
			//change alpha value of overlay and navbar back button
			float alpha = (navFrame.origin.y + 20) / navFrame.size.height;
			self.overlayView.alpha = 1.0 - alpha;
			self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
			
			//change frames of navbar, overlay
			navFrame.origin.y = navFrame.origin.y-differenceFromLast;
			overlayFrame.origin.y = overlayFrame.origin.y-differenceFromLast;
			overlayFrame.size.height = overlayFrame.size.height+differenceFromLast;
			
			//reset navbar, overlay frames to use new views
			self.navigationController.navigationBar.frame = navFrame;
			self.overlayView.frame = overlayFrame;
			
			wasAnimated = YES;
			
		}
		
		//scrolling up, show navbar
	}else if(scrollDirection == ScrollDirectionUp){
		//show nav bar
		if(self.navigationController.navigationBar.frame.origin.y < 20.0
		   && isAtBottom == NO && (self.navigationController.navigationBar.frame.origin.y - differenceFromLast) <= 20.0) {
			CGRect navFrame = self.navigationController.navigationBar.frame;
			CGRect overlayFrame = self.overlayView.frame;
			
			//change alpha value of overlay and navbar back button
			float alpha = (navFrame.origin.y + 20) / navFrame.size.height;
			self.overlayView.alpha = 1.0 - alpha;
			self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
			
			//change frames of navbar, overlay
			navFrame.origin.y = navFrame.origin.y-differenceFromLast;
			overlayFrame.origin.y = overlayFrame.origin.y-differenceFromLast;
			overlayFrame.size.height = overlayFrame.size.height+differenceFromLast;
			
			//reset navbar, overlayframes to use new views
			self.navigationController.navigationBar.frame = navFrame;
			self.overlayView.frame = overlayFrame;
			
			wasAnimated = YES;
		}
	}
	
	if(!wasAnimated){
		if(scrollDirection == ScrollDirectionDown){
			//hide nav bar
			if(self.navigationController.navigationBar.frame.origin.y > -24.0){
				[UIView animateWithDuration:self.animationDuration animations:^{
					self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
																			   -24.0,
																			   self.navigationController.navigationBar.frame.size.width,
																			   self.navigationController.navigationBar.frame.size.height);
					self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
														-44.0,
														self.overlayView.frame.size.width,
														88.0);
					self.overlayView.alpha = 1.0;
					self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.0];
				}];
			}
			
		}else if(scrollDirection == ScrollDirectionUp){
			if(self.navigationController.navigationBar.frame.origin.y < 20.0 && isAtBottom == NO){
				//show navbar
				[UIView animateWithDuration:self.animationDuration animations:^{
					self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
																			   20.0,
																			   self.navigationController.navigationBar.frame.size.width,
																			   self.navigationController.navigationBar.frame.size.height);
					self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
														0.0,
														self.overlayView.frame.size.width,
														self.navigationController.navigationBar.frame.size.height);
					self.overlayView.alpha = 0.0;
					self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:1.0];
				}];
			}
		}
	}
	self.lastScrollViewOffset = currentOffset;
	
}
- (void)endScrollViewScrolling:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	CGFloat currentOffset = scrollView.contentOffset.y;
	CGFloat scrollViewBottomOffset = [self verticalOffsetForBottom:scrollView];
	BOOL isAtBottom = NO;
	
	NSLog(@"overlay frame %@", NSStringFromCGRect(self.overlayView.frame));
	NSLog(@"navbar frame %@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
	
	if(currentOffset >= scrollViewBottomOffset) isAtBottom = YES;
	
	
	//if dragging stopped, but still scrolling
	if(decelerate){
		if(currentOffset<self.startScrollViewOffset && isAtBottom == NO){
			[UIView animateWithDuration:self.animationDuration animations:^{
				
				//show navbar
				self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
																		   20.0,
																		   self.navigationController.navigationBar.frame.size.width,
																		   self.navigationController.navigationBar.frame.size.height);
				self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
													0.0,
													self.overlayView.frame.size.width,
													self.navigationController.navigationBar.frame.size.height);
				
				self.overlayView.alpha = 0.0;
				self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:1.0];
			}];
		}else{
			//hide navbar
			[UIView animateWithDuration:self.animationDuration animations:^{
				self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
																		   -24.0,
																		   self.navigationController.navigationBar.frame.size.width,
																		   self.navigationController.navigationBar.frame.size.height);
				self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
													-44.0,
													self.overlayView.frame.size.width,
													88.0);
				self.overlayView.alpha = 1.0;
				self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.0];
				
			}];
		}
	}
	//if dragging and scrolling stopped
	if(!decelerate){
		//show navbar if at top of scrollview
		if(currentOffset <= -20.0 && isAtBottom == NO){
			[UIView animateWithDuration:self.animationDuration animations:^{
				
				//show navbar
				self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
																		   20.0,
																		   self.navigationController.navigationBar.frame.size.width,
																		   self.navigationController.navigationBar.frame.size.height);
				self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
													0.0,
													self.overlayView.frame.size.width,
													self.navigationController.navigationBar.frame.size.height);
				self.overlayView.alpha = 0.0;
				self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:1.0];
				
			}];
			//hide navbar
		}else if(self.navigationController.navigationBar.frame.origin.y <= 0.0){
			[UIView animateWithDuration:self.animationDuration animations:^{
				self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
																		   -24.0,
																		   self.navigationController.navigationBar.frame.size.width,
																		   self.navigationController.navigationBar.frame.size.height);
				self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
													-44.0,
													self.overlayView.frame.size.width,
													88.0);
				self.overlayView.alpha = 1.0;
				self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.0];
				
			}];
		}else{
			[UIView animateWithDuration:0.2 animations:^{
				//show navbar
				self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
																		   20.0,
																		   self.navigationController.navigationBar.frame.size.width,
																		   self.navigationController.navigationBar.frame.size.height);
				self.overlayView.frame = CGRectMake(self.overlayView.frame.origin.x,
													0.0,
													self.overlayView.frame.size.width,
													self.navigationController.navigationBar.frame.size.height);
				self.overlayView.alpha = 0.0;
				self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:1.0];
				
			}];
			
		}
		
	}
	
}

- (CGFloat)verticalOffsetForBottom:(UIScrollView *)scrollView {
    CGFloat scrollViewHeight = scrollView.bounds.size.height;
    CGFloat scrollContentSizeHeight = scrollView.contentSize.height;
    CGFloat bottomInset = scrollView.contentInset.bottom;
    CGFloat scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight;
    return scrollViewBottomOffset;
}

@end
