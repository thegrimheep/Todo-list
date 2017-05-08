//
//  ViewController.m
//  Todo-list
//
//  Created by David Porter on 5/8/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@import FirebaseAuth;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkUserStatus];
}

-(void)checkUserStatus {
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
    }
}



@end
