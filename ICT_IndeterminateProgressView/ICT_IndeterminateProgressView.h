#import <UIKit/UIKit.h>

@interface ICT_IndeterminateProgressView : UIView
@property(nonatomic, strong, nullable) UIColor* progressTintColor;
@property(nonatomic, strong, nullable) UIColor* trackTintColor;
@property(nonatomic, getter=isAnimating) BOOL animating;
@property(nonatomic) BOOL hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;

@end
