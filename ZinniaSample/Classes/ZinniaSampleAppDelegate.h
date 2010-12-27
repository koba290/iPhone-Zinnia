//
//  ZinniaSampleAppDelegate.h
//  ZinniaSample
//
//  Created by Watanabe Toshinori on 10/12/25.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZinniaSampleViewController;

@interface ZinniaSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ZinniaSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ZinniaSampleViewController *viewController;

@end

