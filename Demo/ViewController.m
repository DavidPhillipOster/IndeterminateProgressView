#import "ViewController.h"
#import "ICT_IndeterminateProgressView.h"
@interface ViewController ()
@property(nonatomic) IBOutlet ICT_IndeterminateProgressView *indeterminateProgressView;
@property(nonatomic) IBOutlet ICT_IndeterminateProgressView *indeterminateProgressView2;
@property(nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
  [_indeterminateProgressView addGestureRecognizer:tapper];
  tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
  [_indeterminateProgressView2 addGestureRecognizer:tapper];
  CGRect frame = _progressView.frame;
  frame.size.height = _indeterminateProgressView.frame.size.height;
  _progressView.frame = frame;
}

- (void)didTap {
  BOOL animating = ! [_indeterminateProgressView isAnimating];
  [_indeterminateProgressView setAnimating:animating];
  [_indeterminateProgressView2 setAnimating:animating];
}


@end
