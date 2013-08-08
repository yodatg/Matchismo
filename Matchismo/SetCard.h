//
//  SetCard.h
//  Matchismo
//
//  Created by Thomas Grant on 07/08/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//
// Each set card has the following attributes:
// shape, color, fill, and count

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

#define SetCardFillTypeSolid @1
#define SetCardFillTypeStriped @2
#define SetCardFillTypeOpen @3
#define SetCardShadingInvalid @0

#define SetCardColourRed @1
#define SetCardColourGreen @2
#define SetCardColourPurple @3
#define SetCardColourInvalid @0


@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) NSNumber *colour;
@property (nonatomic) NSUInteger numberOfShapes;
@property (nonatomic, strong) NSNumber *fillType;

+ (NSArray *)validShapes;
+ (NSArray *)validFillTypes;
+ (NSArray *)validColours;
+ (NSUInteger) validNumberOfShapes;

@end
