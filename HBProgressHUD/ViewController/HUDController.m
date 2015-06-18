//
//  ViewController.m
//  AutoLayoutDemo
//
//  Created by Ron on 20/03/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "HUDController.h"

@interface HUDController()
{
    CGFloat progress;
}
@end

@implementation HUDController
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(IBAction)startProgress:(id)sender
{
    [self setHUDTintColor:[UIColor whiteColor]];
    [self setHUDFillColor:[UIColor colorWithWhite:0.2 alpha:0.5]];
    [self setHUDRedious:30];
    
    [self showHUD:YES];
    progress =0.0;
    [self increaseProgess];
}
-(void)increaseProgess
{
    CGFloat radome =[self randFloatBetween:0.4 and:1.0];
    progress=progress+radome;   
    [self setHUDProgress:progress];
    if (progress<100)
    {
        [self performSelector:@selector(increaseProgess) withObject:nil afterDelay:[self randFloatBetween:0.0 and:0.2]];
    }
    else
    {
        [self showHUD:NO];
    }
}
-(float) randFloatBetween:(float)low and:(float)high
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
