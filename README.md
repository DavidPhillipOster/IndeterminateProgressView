# IndeterminateProgressView
An iOS Objective-C class for an IndeterminateProgressView, like macOS has, but consistent with what iOS already does.

[WNProgressView.m](https://github.com/n8chur/WNProgressView/blob/master/WNProgressView.m) isn't bad - It's subclassing Apple's  UIProgressView and providing indeterminate behavior. 
When not in indeterminate mode, all the additional stuff is hidden, and WNProgressView just behaves like a normal UIProgressView.
When in indeterminate mode, it covers and hides UIProgressView's root layer with a barber pole animation layer of its own. The animation just shifts the X coordinate. One piece of the barber pole is a shape layer, and a replicator layer clones it across the width of the ProgressView.

[WNProgressView.m](https://github.com/n8chur/WNProgressView/blob/master/WNProgressView.m)'s CAAnimation is much smoother than the NSTimer animation I'm doing here.

If Iup expects to be able to flip a progress meter between determinate and indeterminate mode, then WNProgressView.m seems like a good starting place.

If, for some reason, you wanted an indeterminate progress meter on iOS that looks like it belongs on a Mac, you'd just make one piece of the barber pole is a image layer, initialized with a CGGradient that was a sine wave between a saturated blue and a blue that was desaturated almost to white.
