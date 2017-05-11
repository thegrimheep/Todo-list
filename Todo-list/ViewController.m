//
//  ViewController.m
//  Todo-list
//
//  Created by David Porter on 5/8/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "Todo.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)NSMutableArray *allTodos;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *todoContainer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;
@property(nonatomic) FIRDatabaseHandle allTodosHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.todoContainer.hidden = YES;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkUserStatus];
}

-(void)checkUserStatus {
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoingTodoUpdates];
    }
}

-(void)setupFirebase {
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    self.userReference = [[databaseReference child:@"users"]child:self.currentUser.uid];
    
    NSLog(@"USER REFERENCE: %@", self.userReference);
}

-(void)startMonitoingTodoUpdates {
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            
            [allTodos addObject:todoData];
            //for lab append new Todo to allTodos array
            NSLog(@"Todo Title: %@ - Content: %@", todoTitle, todoContent);
        }
    }];
}

- (IBAction)logoutButtonPressed:(id)sender {
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
    
    [self checkUserStatus];
}


- (IBAction)addTodoButtonPressed:(id)sender {
    
    
    if (self.todoContainer.hidden == YES) {
        self.todoContainer.hidden = NO;
    } else if (self.todoContainer.hidden == NO) {
        self.todoContainer.hidden = YES;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    Todo *todo = [self.allTodos objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", todo.title];
    return cell;
}


@end
