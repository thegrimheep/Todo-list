//
//  TVHomeViewController.m
//  Todo-list
//
//  Created by David Porter on 5/9/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import "TVHomeViewController.h"
//#import "Todo.h"

@interface TVHomeViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (stong, nonatomic) NSArray<Todo*> *allTodos;
@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSArray *)allTodos {
//    Todo *firstTodo = [[Todo alloc]init];
//    firstTodo.title = @"First Todo";
//    firstTodo.content = @"This is a todo";
//
//    Todo *secondTodo = [[Todo alloc]init];
//    secondTodo.title = @"Second Todo";
//    secondTodo.content = @"This is the second todo";
//
//    Todo *firstTodo = [[Todo alloc]init];
//    thirdTodo.title = @"Third Todo";
//    thirdTodo.content = @"This is the third a todo";

//return @[firstTodo, secondTodo, thirdTodo];
//
//}

//cell for row at UITableViewCell cell dequeue reusabel cell
//cell.textLabel.text = self.allTodos[indexPath.row].title;
//cell.detailTextLabel.text = self.allTodos[indexPath.row].content;

//then number of rows in seection
//return self.allTodos.count;


@end
