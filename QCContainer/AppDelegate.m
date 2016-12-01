//
//  AppDelegate.m
//  QCContainer
//
//  Created by Jay Thrash on 2/11/14.
//
//

#import "AppDelegate.h"
#import <Quartz/Quartz.h>
#include <ApplicationServices/ApplicationServices.h>


@interface AppDelegate()
@property (weak) IBOutlet NSView *view;
@property (retain) QCView *qcView;

@end

@implementation AppDelegate

NSWindow *fullScreenWindow;
QCView *qcViewFS;

//PresenterView *fullScreenView;

//NSWindow *mainWindow;




- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    
    CGDisplayRegisterReconfigurationCallback (MyCGDisplayReconfigurationCallBack, NULL);

                                                      
    
    // Step 1: Add your Quartz Composition file to the Project. (Opt-Cmd-A)
    // Step 2: Replace the FILENAME on line 28 with the name of your Quartz Composition
    //         file without the extension.
    //         Example: if the filename was MyTestComposition.qtz, then you would replace
    //                  "FILENAME" with "MyTestComposition"
    // Step 3: Compile and run
    
  /*  NSString *path = [[NSBundle mainBundle] pathForResource:@"Test Image"
                                                     ofType:@"qtz"];
    
    
    QCComposition *qc = [QCComposition compositionWithFile:path];
    
    self.qcView = [[QCView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    self.qcView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [self.qcView loadComposition:qc];
    [self.view addSubview:self.qcView];
    [self.qcView startRendering];
    self.qcView.eventForwardingMask = NSAnyEventMask; */
    
    NSScreen *screen = [[NSScreen screens] objectAtIndex:(0)];
    
    [self.window setFrameOrigin:(NSMakePoint(screen.frame.origin.x + 150, screen.frame.origin.y + 150))];
    
    [self.window setLevel:NSMainMenuWindowLevel + 2];
    CreateFullScreenWindow();
}

void CreateFullScreenWindow() {
    
    if ([[NSScreen screens] count] > 1)
    {
    
    
    NSScreen *screen = [[NSScreen screens] objectAtIndex:1];
    NSRect mainDisplayRect = [screen frame];
    fullScreenWindow = [[NSWindow alloc] initWithContentRect: mainDisplayRect styleMask:NSBorderlessWindowMask
                                                     backing:NSBackingStoreBuffered defer:YES];
    [fullScreenWindow setLevel:NSMainMenuWindowLevel+1];
    [fullScreenWindow setOpaque:YES];
    [fullScreenWindow setReleasedWhenClosed:NO];
    //    [fullScreenWindow setHidesOnDeactivate:YES];
    [fullScreenWindow setBackgroundColor:[NSColor redColor]];
    
    NSRect viewRect = NSMakeRect(0.0, 0.0, mainDisplayRect.size.width, mainDisplayRect.size.height);
    //   [fullScreenWindow setCollectionBehavior: NSWindowCollectionBehaviorFullScreenPrimary];
    //   [fullScreenWindow setLevel:NSFloatingWindowLevel];
    [fullScreenWindow makeKeyAndOrderFront:fullScreenWindow];
    
    NSView *FSView = [fullScreenWindow contentView];
    
    [fullScreenWindow setCollectionBehavior:(NSWindowCollectionBehaviorFullScreenPrimary)];
    
    NSApplicationPresentationOptions options = NSApplicationPresentationHideDock | NSApplicationPresentationHideMenuBar;
    
    /*   [FSView enterFullScreenMode:(screen) withOptions: @{NSFullScreenModeAllScreens : @0,
     
     NSFullScreenModeApplicationPresentationOptions: @(options)}];
     */
    
    
    
    
    
    NSString *pathFS = [[NSBundle mainBundle] pathForResource:@"Syphon Test"
                                                       ofType:@"qtz"];
    
    //  CGDirectDisplayID display = activedispla;
    
    QCComposition *qcFS = [QCComposition compositionWithFile:pathFS];
    
    qcViewFS = [[QCView alloc] initWithFrame: FSView.frame];
    
    float height = FSView.frame.size.height;
    float width = FSView.frame.size.width;
    float top = FSView.frame.origin.x;
    float right = FSView.frame.origin.y;
    
    qcViewFS.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [qcViewFS loadComposition:qcFS];
    [FSView addSubview:qcViewFS];
    [qcViewFS startRendering];
    qcViewFS.eventForwardingMask = NSAnyEventMask;
    }
}

void MyCGDisplayReconfigurationCallBack(
                                        CGDirectDisplayID display,
                                        CGDisplayChangeSummaryFlags flags,
                                        void *userInfo) {
    
    if (flags & kCGDisplayAddFlag)  {
        NSLog(@"Display Detected");
      CreateFullScreenWindow();
    
    }
    if (flags & kCGDisplayRemoveFlag) {
        NSLog(@"Display Lost");
      [fullScreenWindow close];
        
    }
}


- (void)applicationWillTerminate:(NSNotification *)notification
{
 /*   [fullScreenWindow orderOut:self];
    
    // Release the display(s)
    if (CGDisplayRelease( kCGDirectMainDisplay ) != kCGErrorSuccess) {
        NSLog( @"Couldn't release the display(s)!" );
        // Note: if you display an error dialog here, make sure you set
        // its window level to the same one as the shield window level,
        // or the user won't see anything.
    }*/
}

@end


