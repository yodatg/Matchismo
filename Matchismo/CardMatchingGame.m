//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Thomas Grant on 18/07/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (readwrite, nonatomic) NSString *descriptionOfMatch;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)setNumberOfCardToMatch:(int)numberOfCardToMatch {
    
    if (numberOfCardToMatch < 2) {
        _numberOfCardToMatch = 2;
    }
    else if (numberOfCardToMatch > 3) {
        _numberOfCardToMatch = 3;
    }
    else {
        _numberOfCardToMatch = numberOfCardToMatch;
    }
}

- (int)numberOfMatchingCards
{
    if (!_numberOfCardToMatch) {
        _numberOfCardToMatch = 2;
    }
    return _numberOfCardToMatch;
}



#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            NSMutableArray *otherContents = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    [otherContents addObject:otherCard.contents];
                }
            }
            if ([otherCards count] < self.numberOfCardToMatch - 1) {
                self.descriptionOfMatch = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            } else {
                int matchScore = [card match:otherCards];
                NSLog(@"%d", matchScore);
                if (matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                        
                    }
                    self.score += matchScore * MATCH_BONUS;
                    self.descriptionOfMatch =
                    [NSString stringWithFormat:@"Matched %@ & %@ for %d points",
                     card.contents,
                     [otherContents componentsJoinedByString:@" & "],
                     matchScore * MATCH_BONUS];
                } else {
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.descriptionOfMatch =
                    [NSString stringWithFormat:@"%@ & %@ don’t match! %d point penalty!",
                     card.contents,
                     [otherContents componentsJoinedByString:@" & "],
                     MISMATCH_PENALTY];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            }
            else {
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}

@end
