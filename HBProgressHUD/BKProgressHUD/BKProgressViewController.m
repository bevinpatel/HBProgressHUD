//
//  BKProgressViewController.m
//
//  Copyright 2015 Bevin Patel.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "BKProgressViewController.h"
#import "BKProgressHUD.h"

@interface BKProgressViewController ()
{
    BKProgressHUD *HUD;
}
@end

@implementation BKProgressViewController

-(void)loadView
{
    [super loadView];
    if (!HUD)
    {
        HUD = [[BKProgressHUD alloc]init];
        [HUD setRedious:10];
        [HUD setTranslatesAutoresizingMaskIntoConstraints:NO];
        [HUD setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        [self.view addSubview:HUD];

        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:HUD
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:HUD
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:HUD
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:HUD
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
        [HUD setHidden:YES];
    }
}
#pragma mark-
-(void)setHUDProgress:(CGFloat)proPercent
{
    [HUD setProgress:proPercent];
}
-(void)setHUDRedious:(NSInteger)redious
{
    [UIView transitionWithView:HUD
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [HUD setRedious:(int32_t)redious];
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}
-(void)setHUDTintColor:(UIColor *)tintColor
{
    [HUD setTintColor:tintColor];
}
-(void)setHUDFillColor:(UIColor *)fillColor
{
    [HUD setFillColor:fillColor];
}
-(void)showHUD:(BOOL)isShow
{
    [UIView transitionWithView:HUD
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [HUD setHidden:!isShow];
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}
#pragma mark-

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
