//
//  ScoreViewController.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/22/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "ScoreViewController.h"
#import "Score.h"

@interface ScoreViewController ()

@property (weak, nonatomic) IBOutlet UITextView *scores;

@end

@implementation ScoreViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for(NSMutableString *score in [defaults objectForKey:@"Scores"])
    {
        self.scores.text = [self.scores.text stringByAppendingString:score];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
