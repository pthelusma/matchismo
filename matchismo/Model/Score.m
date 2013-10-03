//
//  Score.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/29/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "Score.h"

@implementation Score

@synthesize date;
@synthesize score;
@synthesize game;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeInt:self.score forKey:@"score"];
    [encoder encodeObject:self.game forKey:@"game"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        //decode properties, other class vars
        self.date = [decoder decodeObjectForKey:@"date"];
        self.score = [decoder decodeIntegerForKey:@"score"];
        self.game = [decoder decodeObjectForKey:@"game"];
    }
    return self;
}


@end
