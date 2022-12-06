//
//  bouncing_screensaverView.h
//  bouncing screensaver
//

#import <ScreenSaver/ScreenSaver.h>

@interface bouncing_screensaverView : ScreenSaverView

@property NSImage * logo;
@property NSColor * logoColor;
@property NSRect dirtyRect;

@property int logoWidth, logoHeight;
@property int x, y;
@property int xSpeed, ySpeed;
@end

