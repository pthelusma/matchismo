//
//  SetPlayingCard.h
//  matchismo
//
//  Created by Pierre Thelusma on 9/22/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card
@property (nonatomic) int number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSDictionary *shading;
@property (strong, nonatomic) NSString *shade;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) BOOL selected;

+ (NSArray *) Numbers;
+ (NSArray *) Symbols;
+ (NSArray *) Shadings;
+ (NSArray *) Colors;

@end
