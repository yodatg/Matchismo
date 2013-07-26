//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Thomas Grant on 18/07/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card, Deck;

@interface CardMatchingGame : NSObject

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *descriptionOfMatch;
@property (nonatomic) int numberOfCardToMatch;

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
