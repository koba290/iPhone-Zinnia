//
//  ZinniaSampleViewController.m
//  ZinniaSample
//
//  Created by Watanabe Toshinori on 10/12/25.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import "ZinniaSampleViewController.h"
#import "Result.h"


@implementation ZinniaSampleViewController

@synthesize canvas;
@synthesize resultsView;
@synthesize values;
@synthesize scores;
@synthesize queue;
@synthesize touchPoint;
@synthesize points;
@synthesize recognizer;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.queue = [[[NSOperationQueue alloc] init] autorelease];
	[queue setMaxConcurrentOperationCount:1];
	self.recognizer = [[Recognizer alloc] initWithCanvas:canvas];
}


#pragma mark -
#pragma mark Actions

- (IBAction)clear:(id)sender {
	[recognizer clear];
	
	[queue cancelAllOperations];
	
	canvas.image = nil;
	
	for (UILabel *value in values) {
		value.text = nil;
	}
	
	for (UILabel *score in scores) {
		score.text = nil;
	}
	
	resultsView.hidden = YES;
}


#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.points = [NSMutableArray array];
	
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:canvas];
	
	[points addObject:[NSValue valueWithCGPoint:touchPoint]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
    UITouch *touch = [touches anyObject]; 
    CGPoint currentPoint = [touch locationInView:canvas];
    
    UIGraphicsBeginImageContext(canvas.frame.size);
    
    [canvas.image drawInRect:CGRectMake(0, 0, canvas.frame.size.width, canvas.frame.size.height)];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());

    canvas.image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
	
	[points addObject:[NSValue valueWithCGPoint:currentPoint]];
 
    self.touchPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

	// Recognize on new thread.
	[queue addOperationWithBlock:^{

		NSArray *results = [recognizer classify:points];
		
		// Update UI on main thread.
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{

			if (results) {
				resultsView.hidden = NO;

				for (int i = 0; i < [results count]; i++) {
					Result *result = [results objectAtIndex:i];
					UILabel *value = [values objectAtIndex:i];
					UILabel *score = [scores objectAtIndex:i];
					
					value.text = result.value;
					score.text = [NSString stringWithFormat:@"%.3f", [result.score floatValue]];
				}

			} else {
				resultsView.hidden = YES;
			}
		}];
	}];
}


#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
	self.recognizer = nil;
    self.queue = nil;
	self.points = nil;
	
	self.canvas = nil;
	self.resultsView = nil;
    self.values = nil;
    self.scores = nil;
	
    [super dealloc];
}

@end
