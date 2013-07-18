//
//  PlayingCard.h
//  Matchismo
//
//  Created by Thomas Grant on 08/07/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
