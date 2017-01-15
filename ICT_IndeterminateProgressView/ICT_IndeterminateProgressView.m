#import "ICT_IndeterminateProgressView.h"
// This file compiles as manual reference counting (ARC off)
// Use -fno-objc-arc in Xcode's target > Build phases > Compile sources > ICT_IndeterminateProgressView.m

@interface ICT_IndeterminateProgressView ()
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger offset;
@property (nonatomic) BOOL cycle;
@end

enum {
  kSlugWidth = 20
};

static void ParallelogramFill(CGRect r) {
  UIBezierPath *path = [UIBezierPath bezierPath];
  CGFloat dx = r.size.width/2;
  [path moveToPoint:CGPointMake(r.origin.x - dx, r.origin.y)];
  [path addLineToPoint:CGPointMake(r.origin.x + r.size.width - dx, r.origin.y)];
  [path addLineToPoint:CGPointMake(r.origin.x + r.size.width + dx, r.origin.y + r.size.height)];
  [path addLineToPoint:CGPointMake(r.origin.x + dx, r.origin.y + r.size.height)];
  [path closePath];
  [path fill];
}

@implementation ICT_IndeterminateProgressView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  [self initializeIndeterminateProgressView];
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self initializeIndeterminateProgressView];
  return self;
}

- (void)initializeIndeterminateProgressView {
  [self setBackgroundColor:[UIColor colorWithWhite:(CGFloat)(0xa8/255.0) alpha:1]];
  [self setProgressTintColor:[UIColor colorWithRed:(CGFloat)(0x0A/255.0)
                                green:(CGFloat)(0x5F/255.0)
                                 blue:(CGFloat)(0xFC/255.)
                                alpha:1]];
}

- (void)dealloc {
  [_timer invalidate];
  [_timer release];
  [_progressTintColor release];
  [super dealloc];
}

- (void)drawRect:(CGRect)rect {
  CGRect frame = [self bounds];
  if ([self trackTintColor]) {
    [[self trackTintColor] set];
    UIRectFill(frame);
  }
  [[self progressTintColor] set];
  CGRect remainder;
  if (6 < frame.size.height) {
    UIRectFrame(frame);
    remainder = CGRectInset(frame, 2, 2);
  } else {
    remainder = frame;
  }
  if (0 == _offset) {
    _cycle = ! _cycle;
  }
  BOOL doDraw = _cycle;
  if (0 < remainder.size.width) {
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSaveGState(c);
    CGContextClipToRect(c, remainder);
    CGRect slug;
    remainder = UIEdgeInsetsInsetRect(remainder, UIEdgeInsetsMake(0, -kSlugWidth/2, 0, -kSlugWidth/2));
    CGRectDivide(remainder, &slug, &remainder, MIN((CGFloat)_offset, remainder.size.width), CGRectMinXEdge);
    if (doDraw) {
      ParallelogramFill(slug);
    }
    doDraw = ! doDraw;
    while (!CGRectIsEmpty(remainder)) {
      CGRectDivide(remainder, &slug, &remainder, kSlugWidth, CGRectMinXEdge);
      if (doDraw) {
        ParallelogramFill(slug);
      }
      doDraw = ! doDraw;
    }
    CGContextRestoreGState(c);
  }
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  [self setNeedsDisplay];
}

- (void)doTimer:(NSTimer *)timer {
  _offset = (_offset + 1) % kSlugWidth;
  [self setNeedsDisplay];
}

- (void)setTimer:(NSTimer *)timer {
  if (_timer != timer) {
    [_timer invalidate];
    [_timer release];
    _timer = timer;
    [timer retain];
  }
}

- (void)setProgressTintColor:(UIColor *)color {
  if (_progressTintColor != color) {
    [_progressTintColor release];
    _progressTintColor = color;
    [_progressTintColor retain];
    [self setNeedsDisplay];
  }
}

- (void)setHidesWhenStopped:(BOOL)hidesWhenStopped {
  if (_hidesWhenStopped != hidesWhenStopped) {
    _hidesWhenStopped = hidesWhenStopped;
  }
}

- (void)setAnimating:(BOOL)animating {
  if (_animating != animating) {
    _animating = animating;
    if (_animating) {
      [self setTimer:[NSTimer scheduledTimerWithTimeInterval:1/20.0
                                                      target:self
                                                    selector:@selector(doTimer:)
                                                    userInfo:nil
                                                     repeats:YES]];
      [self setNeedsDisplay];
    } else {
      [self setTimer:nil];
      if (_hidesWhenStopped) {
        [self setHidden:YES];
      } else {
        [self setNeedsDisplay];
      }
    }
  }
}

- (void)startAnimating {
  [self setAnimating:YES];
}

- (void)stopAnimating {
  [self setAnimating:NO];
}

@end
