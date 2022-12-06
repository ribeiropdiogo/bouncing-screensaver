//
//  bouncing_screensaverView.m
//  bouncing screensaver
//

#import "bouncing_screensaverView.h"
#define WIDTH ([NSScreen mainScreen].frame.size.width)
#define HEIGHT ([NSScreen mainScreen].frame.size.height)

@implementation bouncing_screensaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        
        const float fps = 30.0f;
        [self setAnimationTimeInterval:1/fps];

        
        const int speed = WIDTH / (10.0 * fps);
       
        self.logoWidth = 200;
        self.logoHeight = 145;
        self.x = WIDTH / 2.0 - self.logoWidth / 2.0;
        self.y = HEIGHT / 2.0 - self.logoHeight / 2.0;
        self.dirtyRect = NSMakeRect(self.x, self.y, self.logoWidth, self.logoHeight);
        self.xSpeed = speed * (arc4random() % 2 == 0 ? 1 : -1);
        self.ySpeed = speed * (arc4random() % 2 == 0 ? 1 : -1);
        
        // To change the logo being used, just update the next line
        NSString * logoPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"troll" ofType:@"png"];
        
        
        self.logo = [[NSImage alloc] initWithContentsOfFile:logoPath];
        [self hitWall];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rectParam
{
    NSRect rect;
    
    rect.size = NSMakeSize(self.logoWidth, self.logoHeight);
    
    self.x += self.xSpeed;
    self.y += self.ySpeed;
    rect.origin = CGPointMake(self.x, self.y);
    self.dirtyRect = rect;
    
    [self.logo drawInRect:rect];
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    if (center.x + self.logoWidth / 2 >= WIDTH || center.x - self.logoWidth / 2 <= 0) {
        self.xSpeed *= -1;
        [self hitWall];
    }
    
    if (center.y + self.logoHeight / 2 >= HEIGHT || center.y - self.logoHeight / 2 <= 0) {
        self.ySpeed *= -1;
        [self hitWall];
    }

}

- (void)hitWall
{
    [self.logo lockFocus];
    [self.logoColor set];
    [self.logo unlockFocus];
}

- (void)animateOneFrame
{
    [self setNeedsDisplayInRect:self.dirtyRect];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
