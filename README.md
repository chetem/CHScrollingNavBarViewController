CHScrollingNavBarViewController
===============================

Getting Started:
----------------

To use this class, simply subclass it in replace of your UIViewController. 

NOTE: You must set a navigation bar tint color prior to use. 

-Inside ViewDidLoad, call `-initNavBarScrollingForScrollView:` and pass in your scrollable view (i.e. UIScrollView, UITableView, UICollectionView)

-You can then set the `animationDuration` property (optional), which controls the duration for which an animation will complete if the navigation bar did not fully scroll up/down. 

-Then inside your scrollView Delegate methods, call the following passing through the 'scrollView' and 'decelerate' parameters:
+ `-startNavBarScrolling:` in `-scrollViewWillBeginDragging:`
+ `-followScrollViewScrolling:` in `-scrollViewDidScroll:` 
+ `-endScrollViewScrolling:willDecelerate:` in `-scrollViewDidEndDragging:willDecelerate:` 

That's it! Your navigation bar should scroll along with your scrollable view. See the example for clarification.

Screen Shots:
-------------
![alt text](https://github.com/chetem/CHScrollingNavBarViewController/raw/master/Sample_Screenshots/Screen_shot_1.png "Screen Shot 1") &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ![alt text](https://github.com/chetem/CHScrollingNavBarViewController/raw/master/Sample_Screenshots/Screen_shot_2.png "Screen Shot 2")
