#import <UIKit/UIKit.h>

@interface ICT_IndeterminateProgressView : UIView
@property(nonatomic, nullable, strong) UIColor *foregroundColor;
@property(nonatomic, getter=isAnimating) BOOL animating;
@property(nonatomic) BOOL hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;

@end
