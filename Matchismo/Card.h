//
//  Card.h
//  Matchismo
//
//  Created by Thomas Grant on 08/07/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString* contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

-(int)match:(NSArray *)otherCards;

@end
