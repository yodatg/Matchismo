//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Thomas Grant on 08/07/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchedLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) CardMatchingGame *game;
@end

@implementation CardGameViewController


- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
        _game.numberOfCardToMatch = self.segmentedControl.selectedSegmentIndex + 2;
    }
    
    return _game;
}


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];

}

- (void)updateUI
{
    
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        UIImage *cardbackImage = [UIImage imageNamed:@"cardback.png"];
                
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
         [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        if (!card.isFaceUp) {
            [cardButton setImage:cardbackImage forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.matchedLabel.text = self.game.descriptionOfMatch;
    
    
    
}
- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
}

- (IBAction)deal:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
    
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
}

- (IBAction)cardModeChanged:(UISegmentedControl *)sender {
    
    switch ([sender selectedSegmentIndex]) {
        case 0:
            self.game.numberOfCardToMatch = 2;
            break;
        case 1:
            self.game.numberOfCardToMatch = 3;
            break;
        default:
            self.game.numberOfCardToMatch = 2;
            break;
    }
    
}

- (IBAction)sliderValueChanged:(id)sender {
    
    int sliderValue;
    sliderValue = lroundf(self.slider.value);
    [self.slider setValue:sliderValue animated:NO];
    
    if ([self.game.pastMatches count] != 0) {
        if (sliderValue >= 1) {
            self.matchedLabel.alpha = 0.5;
        }
        else {
            self.matchedLabel.alpha = 1;
        }

        self.slider.maximumValue = [self.game.pastMatches count] - 1;
        self.matchedLabel.text = [self.game.pastMatches objectAtIndex:[(UISlider *)sender value]];
        [self.slider setValue:[(UISlider *)sender value] animated:YES];
        
    }
   
    
}




@end
