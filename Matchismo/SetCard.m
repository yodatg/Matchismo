//
//  SetCard.m
//  Matchismo
//
//  Created by Thomas Grant on 07/08/2013.
//  Copyright (c) 2013 Thomas Grant. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validShapes {
    
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validFillTypes {
    
    return @[SetCardFillTypeOpen, SetCardFillTypeSolid, SetCardFillTypeStriped];
    
}

+ (NSArray *)validColours {
    
    return @[SetCardColourGreen, SetCardColourPurple, SetCardColourRed];
}

- (void)setShape:(NSString *)shape {
    
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (void)setNumberOfShapes:(NSUInteger)numberOfShapes {
    
    if (numberOfShapes <= [SetCard validNumberOfShapes]) {
        _numberOfShapes = numberOfShapes;
    }
}

- (void)setColour:(NSNumber *)colour {
    
    if ([[SetCard validColours] containsObject:colour]) {
        _colour = colour;
    }
}

- (void)setFillType:(NSNumber *)fillType {
    
    if ([[SetCard validFillTypes] containsObject:fillType]) {
        _fillType = fillType;
    }
}

- (NSString *)contents
{
    NSString *contentString = @"";
    for (int i = 0; i < self.numberOfShapes; i++) {
        contentString = [contentString stringByAppendingString:self.shape];
        NSLog(@"Content string = %@", contentString);
    }
    
    return contentString;
}

+ (NSUInteger) validNumberOfShapes {
    
    return 3;
}


- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    if ([otherCards count] == 2) {
        
        SetCard *firstCard = [otherCards objectAtIndex:0];
        SetCard *secondCard = [otherCards objectAtIndex:1];
        
        // check to see if any attributes are the same
        if (self.numberOfShapes == firstCard.numberOfShapes
            && self.numberOfShapes == secondCard.numberOfShapes) {
            score = 1;
        }
        else if ([self.shape isEqualToString:firstCard.shape]
            && [self.shape isEqualToString:secondCard.shape]) {
            
            score = 1;
        }
        else if([self.colour isEqualToNumber:firstCard.colour]
           && [self.colour isEqualToNumber:secondCard.colour]) {
            
        score = 1;
        }
        else if ([self.fillType isEqualToNumber:firstCard.fillType]
                 && [self.fillType isEqualToNumber:secondCard.fillType]) {
            score = 1;
        }
        
        // check to see if all attributes are different
        else if (self.numberOfShapes != firstCard.numberOfShapes
                 && self.numberOfShapes != secondCard.numberOfShapes
                 && firstCard.numberOfShapes != secondCard.numberOfShapes) {
            
            score = 4;
            
        }
        // check to see if all attributes are different
        else if (self.colour != firstCard.colour
                 && self.colour != secondCard.colour
                 && firstCard.colour != secondCard.colour) {
            
            score = 4;
            
        }

        // check to see if all attributes are different
        else if (self.fillType != firstCard.fillType
                 && self.fillType != secondCard.fillType
                 && firstCard.fillType != secondCard.fillType) {
            
            score = 4;
            
        }

        // check to see if all attributes are different
        else if (self.shape != firstCard.shape
                 && self.shape != secondCard.shape
                 && firstCard.shape != secondCard.shape) {
            
            score = 4;
            
        }

    }

    return score;
}



@end
