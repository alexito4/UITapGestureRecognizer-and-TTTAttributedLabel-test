//
//  ViewController.m
//  tapgesturetest
//
//  Created by Alejandro Martinez on 17/11/2014.
//  Copyright (c) 2014 Alejandro Martinez. All rights reserved.
//

#import "ViewController.h"
#import "TTTAttributedLabel.h"

@interface ViewController () <TTTAttributedLabelDelegate>
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *toplabel;

@property (weak, nonatomic) IBOutlet UIView *viewtop;
@property (weak, nonatomic) IBOutlet UIView *viewbottom;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *botlabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // This is a normal implementation that should work.
    // But the TTTAttributedLabel is not being called when taping on the link.
    UITapGestureRecognizer *taptop = [[UITapGestureRecognizer alloc] init];
    [taptop addTarget:self action:@selector(viewtopTap:)];
    [self.viewtop addGestureRecognizer:taptop];
    
    [self.toplabel addLinkToURL:[NSURL URLWithString:@"http://google.com"] withRange:[self.toplabel.text rangeOfString:@"TTTAttributedLabel"]];
    self.toplabel.delegate = self;
    
    
    
    // ----------------
    
    // Using cancelsTouchesInView solves the problem but it should not bee neded.
    // Adding this makes the system call the tapgesture action AND the controls (like the button) action.
    UITapGestureRecognizer *tapbot = [[UITapGestureRecognizer alloc] init];
    tapbot.cancelsTouchesInView = NO;
    [tapbot addTarget:self action:@selector(viewbotTap:)];
    [self.viewbottom addGestureRecognizer:tapbot];
    
    [self.botlabel addLinkToURL:[NSURL URLWithString:@"http://google.com"] withRange:[self.botlabel.text rangeOfString:@"TTTAttributedLabel"]];
    self.botlabel.delegate = self;
    
    
    
    /*
     You can test.
     On the top view:
     - taping on the button only displays the button action. 👍
     - tapping on the background only displays the gesture action 👍
     - taping on the label does not fire the label delegate 👎
     
     On the bottom view:
     - taping on the button displays the button action and the gesture action. 👀
     - tapping on the background only displays the gesture action 👍
     - taping on the label does not fire the label delegate 👍
     
     */
}

- (IBAction)buttonaction:(id)sender {
    NSLog(@"button action");
}

- (void)viewtopTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"top tap");
}

- (IBAction)button2action:(id)sender {
    NSLog(@"button 2 action");
}

- (void)viewbotTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"bot tap");
}

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    if (label == self.toplabel) {
        NSLog(@"top label link");
    } else {
        NSLog(@"bot label link");
    }
}

@end
