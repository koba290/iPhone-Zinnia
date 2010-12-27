//
//  Result.m
//  ZinniaSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import "Result.h"


@implementation Result
@synthesize value;
@synthesize score;


- (void)dealloc {
	
    self.value = nil;
    self.score = nil;

	[super dealloc];
}

@end
