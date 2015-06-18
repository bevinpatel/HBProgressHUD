//
//  HUDViewDemoController.m
//  AutoLayoutDemo
//
//  Created by Ron on 14/04/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "HUDViewDemoController.h"

@interface HUDViewDemoController ()
{
    CGFloat progress;
}
@end

@implementation HUDViewDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [fbHUD setHidden:YES];
    [fbHUD setHidden:YES];
    [gPlusHUD setHidden:YES];
    [linkInHUD setHidden:YES];
    [tweeterHUD setHidden:YES];
    [androidHUD setHidden:YES];
    [blackBerryHUD setHidden:YES];
    [appleHudHUD setHidden:YES];
    [windowsHUD setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startProgress:(id)sender
{
    [fbHUD setHidden:NO];
    [fbHUD setHidden:NO];
    [gPlusHUD setHidden:NO];
    [linkInHUD setHidden:NO];
    [tweeterHUD setHidden:NO];
    [androidHUD setHidden:NO];
    [blackBerryHUD setHidden:NO];
    [appleHudHUD setHidden:NO];
    [windowsHUD setHidden:NO];
    progress =0.0;
    [self increaseProgess];
}
-(void)increaseProgess
{
    CGFloat radome =[self randFloatBetween:0.4 and:1.0];
    progress=progress+radome;
    
    [fbHUD setProgress:progress];
    [fbHUD setProgress:progress];
    [gPlusHUD setProgress:progress];
    [linkInHUD setProgress:progress];
    [tweeterHUD setProgress:progress];
    [androidHUD setProgress:progress];
    [blackBerryHUD setProgress:progress];
    [appleHudHUD setProgress:progress];
    [windowsHUD setProgress:progress];
    
    
    if (progress<100)
    {
        [self performSelector:@selector(increaseProgess) withObject:nil afterDelay:[self randFloatBetween:0.0 and:0.2]];
    }
    else
    {
        [fbHUD setHidden:YES];
        [fbHUD setHidden:YES];
        [gPlusHUD setHidden:YES];
        [linkInHUD setHidden:YES];
        [tweeterHUD setHidden:YES];
        [androidHUD setHidden:YES];
        [blackBerryHUD setHidden:YES];
        [appleHudHUD setHidden:YES];
        [windowsHUD setHidden:YES];
    }
}
-(float) randFloatBetween:(float)low and:(float)high
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}
@end
