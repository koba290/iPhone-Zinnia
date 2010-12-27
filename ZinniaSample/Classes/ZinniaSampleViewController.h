//
//  ZinniaSampleViewController.h
//  ZinniaSample
//
//  Created by Watanabe Toshinori on 10/12/25.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recognizer.h"

@interface ZinniaSampleViewController : UIViewController {

	// UI
	UIImageView *canvas;
	UIView *resultsView;
	NSArray *values;
	NSArray *scores;
	
	// properties
	NSOperationQueue *queue;
    CGPoint touchPoint;
	NSMutableArray *points;
	Recognizer *recognizer;

}

@property (nonatomic, retain) IBOutlet UIImageView *canvas;
@property (nonatomic, retain) IBOutlet UIView *resultsView;
@property (nonatomic, retain) IBOutletCollection (UILabel) NSArray *values;
@property (nonatomic, retain) IBOutletCollection (UILabel) NSArray *scores;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, assign) CGPoint touchPoint;
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) Recognizer *recognizer;

- (IBAction)clear:(id)sender;

@end
