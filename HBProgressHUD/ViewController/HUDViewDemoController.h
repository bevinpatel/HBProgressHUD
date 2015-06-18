//
//  HUDViewDemoController.h
//  AutoLayoutDemo
//
//  Created by Ron on 14/04/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKProgressHUD.h"

@interface HUDViewDemoController : UIViewController
{
    IBOutlet BKProgressHUD *fbHUD;
    IBOutlet BKProgressHUD *gPlusHUD;
    IBOutlet BKProgressHUD *linkInHUD;
    IBOutlet BKProgressHUD *tweeterHUD;
    IBOutlet BKProgressHUD *androidHUD;
    IBOutlet BKProgressHUD *blackBerryHUD;
    IBOutlet BKProgressHUD *appleHudHUD;
    IBOutlet BKProgressHUD *windowsHUD;
}
-(IBAction)startProgress:(id)sender;
@end
