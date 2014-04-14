CHScrollingNavBarViewController
===============================

Getting Started:

-To use this class, simply subclass it in replace of your UIViewController. 

NOTE: You must set a navigation bar tint color prior to use. 

-Inside ViewDidLoad, call -initNavBarScrollingForScrollView: and pass in your scrollable view (i.e. UIScrollView, UITableView)
NOTE: Not yet tested with a UICollectionView. 

-You can then set the animationDuration property (optional), which controls the duration for which an animation will complete if the navigation bar did not fully scroll up/down. 

-Then inside your scrollView Delegate methods, call the following:
startNavBarScrolling: in scrollViewWillBeginDragging:
followScrollViewScrolling: in scrollViewDidScroll: 
endScrollViewScrolling:willDecelerate: in scrollViewDidEndDragging:willDecelerate: 

That's it! Your navigationBar should scroll along with your scrollable view.
