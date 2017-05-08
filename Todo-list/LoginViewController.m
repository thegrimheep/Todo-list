//
//  LoginViewController.m
//  Todo-list
//
//  Created by David Porter on 5/8/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import "LoginViewController.h"

@import FirebaseAuth;

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)loginPressed:(id)sender {
    
//    NSError *signOutError;
//    [[FIRAuth auth] signOut:&signOutError];
    
    [[FIRAuth auth] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Signing in: %@", error.localizedDescription);
        }
        if (user) {
            NSLog(@"Logged in user: %@", user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (IBAction)signupPressed:(id)sender {
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Signing up new user: %@", error.localizedDescription);
        }
        if (user) {
            NSLog(@"Successfully signup user: %@", user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }    }];
}

@end
