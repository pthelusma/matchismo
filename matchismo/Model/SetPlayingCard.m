//
//  SetPlayingCard.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/22/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard

@synthesize number;
@synthesize symbol;
@synthesize shading;
@synthesize color;
@synthesize selected;

- (void) setShade:(NSString *)shade
{
    _shade = shade;
    
    if([shade isEqualToString:@"empty"])
    {
        shading= @{
                        NSForegroundColorAttributeName: [UIColor whiteColor],
                        NSStrokeColorAttributeName: color,
                        NSStrokeWidthAttributeName: @-5
                        };
    }
    
    if([shade isEqualToString:@"filled"])
    {
        shading= @{
                        NSForegroundColorAttributeName: color,
                        NSStrokeWidthAttributeName: @-5
                        };
    }
    
    if([shade isEqualToString:@"shaded"])
    {
        shading = @{
                         NSStrokeWidthAttributeName : @-5,
                         NSStrokeColorAttributeName : color,
                         NSForegroundColorAttributeName : [color colorWithAlphaComponent:0.5]
                         
                         };
    }
}

+ (NSArray *) Numbers
{
    static NSArray *Numbers = nil;
    
    if(!Numbers)
    {
        Numbers = @[@1,@2,@3];
    }
    
    return Numbers;
    
}

+ (NSArray *) Symbols
{
    static NSArray *Symbols = nil;
    
    if(!Symbols)
    {
        Symbols = @[@"●", @"■", @"▲"];
    }
    
    return Symbols;
}

+ (NSArray *) Shadings
{
    static NSArray *Shadings = nil;
    
    if(!Shadings)
    {
        
        Shadings = @[@"empty", @"filled", @"shaded"];
    
    }
    
    return Shadings;
}

+(NSArray *) Colors
{
    static NSArray *Colors = nil;
    
    if(!Colors)
    {
        Colors = @[[UIColor redColor],[UIColor greenColor], [UIColor blueColor]];
    }
    
    return  Colors;
}

- (NSMutableAttributedString *)contents
{
    
    NSMutableString *initialContent = [[NSMutableString alloc] initWithString:@""];
    
    for(int i = 0; i < number; i++)
    {
        [initialContent appendString:symbol];
    }
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:initialContent];
    
    [content addAttributes:shading range:NSMakeRange(0,[content length])];
    
    return content;
}

@end
