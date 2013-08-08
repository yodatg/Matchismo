//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Thomas Grant on 07/08/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    
    self = [super init];
    
    for (int i = 1; i <= [SetCard validNumberOfShapes]; i++) {
        for (id shape in [SetCard validShapes]) {
            for (id fillType in [SetCard validFillTypes]) {
                for (id colour in [SetCard validColours]) {
                    SetCard *card = [[SetCard alloc] init];
                    card.numberOfShapes = i;
                    card.shape = shape;
                    card.fillType = fillType;
                    card.colour = colour;
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
    
    return self;
}

@end
