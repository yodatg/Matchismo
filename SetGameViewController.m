//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Thomas Grant on 07/08/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SetGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "Card.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) CardMatchingGame *game;
@end

@implementation SetGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]];
        _game.numberOfCardToMatch = 3;
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    
}


- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        NSMutableAttributedString *string = [self createAttributedStringForCard:card];
        [cardButton setAttributedTitle:string forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    
}

- (NSMutableAttributedString *)createAttributedStringForCard:(Card *)card {
    
    
    SetCard *setCard = (SetCard *)card;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:card.contents];
    NSLog(@"Set Card colour = %@", setCard.colour);
    // extract attributes
    if ([setCard.colour isEqual: SetCardColourGreen]) {
        
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 3)];
        NSLog(@"setting colour to green");
    }
    if ([setCard.colour isEqual: SetCardColourPurple]) {
        
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, 3)];
        NSLog(@"setting colour to purple");
    }
    if ([setCard.colour isEqual: SetCardColourRed]) {
        
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
        NSLog(@"setting colour to red");
    }

    
    return string;
    
}
@end
