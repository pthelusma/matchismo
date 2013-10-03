//
//  SetPlayingCardDeck.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/24/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetPlayingCardDeck

-(id)init
{
    self = [super init];
    
    if(self)
    {
        for(NSNumber *number in [SetPlayingCard Numbers])
        {
            for(UIColor *color in [SetPlayingCard Colors])
            {
                for(NSAttributedString *symbol in [SetPlayingCard Symbols])
                {
                    for(NSString *shade in [SetPlayingCard Shadings])
                    {
                        SetPlayingCard *card = [[SetPlayingCard alloc] init];
                        
                        card.number = [number intValue];
                        card.color = color;
                        card.symbol = symbol;
                        card.shade = shade;
                        
                        [self addCard:(card) atTop:(YES)];
                        
                    }
                }
            }
        }
    }
    
    return self;
}

@end
