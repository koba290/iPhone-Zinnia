//
//  Zinnia.h
//  ZinniaSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zinnia.h"


@interface Recognizer : NSObject {

	zinnia_recognizer_t *recognizer;
	zinnia_character_t *character;
	int count;
	
}

- (id)initWithCanvas:(UIImageView *)canvas;
- (NSArray *)classify:(NSArray *)points;
- (void)clear;

@end
