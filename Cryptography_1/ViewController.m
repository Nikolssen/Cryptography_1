//
//  ViewController.m
//  Cryptography_1
//
//  Created by Admin on 05.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "ViewController.h"
#import "Playfair.h"
#import "RailwayFence.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *PlayfairField;
@property (weak, nonatomic) IBOutlet UITextField *PlayfairKeyField;
@property (weak, nonatomic) IBOutlet UISwitch *PlayfairSwitch;
@property (weak, nonatomic) IBOutlet UIButton *PlayfairSubmittButton;

@property (weak, nonatomic) IBOutlet UITextView *railwayFenceField;
@property (weak, nonatomic) IBOutlet UIStepper *railwayFenceRowStepper;
@property (weak, nonatomic) IBOutlet UILabel *railwayFenceRowLabel;
@property (weak, nonatomic) IBOutlet UIButton *railwayFenceSubmitButton;
@property (weak, nonatomic) IBOutlet UISwitch *railwayFenceSwitch;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PlayfairSubmittButton.layer.cornerRadius = 5;
    self.railwayFenceSubmitButton.layer.cornerRadius = 5;
    
    
    
}
- (IBAction)submitPlayfairCypherization:(id)sender {
    if ([[self.PlayfairKeyField text] isEqualToString:@""])
        return;
    if ([[self.PlayfairField text] isEqualToString:@""])
        return;
    Playfair* cryptographer = [[Playfair alloc] initWithKey:[self.PlayfairKeyField text]];
    NSString* myString = [NSString new];
    if (self.PlayfairSwitch.on)
      myString=[cryptographer decypher:[self.PlayfairField text]];
    else
       myString= [cryptographer cypher:[self.PlayfairField text]];
    [self.PlayfairField setText:myString];
}

- (IBAction)railwayFenceRowsStepperValueChanged:(id)sender {
    [self.railwayFenceRowLabel setText: [NSString stringWithFormat:@"%d", (int) self.railwayFenceRowStepper.value]];
     
}
- (IBAction)submitRailwayCypherization:(id)sender {
    RailwayFence* cryptographer = [[RailwayFence alloc] initWithNumberOfRows:(int) self.railwayFenceRowStepper.value];
        NSString* myString = [NSString new];
    if (self.railwayFenceSwitch.on)
      myString=[cryptographer decypher:[self.railwayFenceField text]];
    else
       myString= [cryptographer cypher:[self.railwayFenceField  text]];
    [self.railwayFenceField setText:myString];
}

@end
