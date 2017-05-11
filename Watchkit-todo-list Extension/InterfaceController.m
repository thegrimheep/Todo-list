//
//  InterfaceController.m
//  Watchkit-todo-list Extension
//
//  Created by David Porter on 5/9/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import "InterfaceController.h"
#import "TodoRowController.h"
#import "TodoDetailInterfaceController.h"
#import "Todo.h"

@import WatchConnectivity;

@interface InterfaceController () <WCSessionDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@property(strong, nonatomic) NSArray <Todo*> *allTodos;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self setupTable];

    // Configure interface objects here.
}

-(void)setupTable {
    [self.table setNumberOfRows:self.allTodos.count withRowType:@"TodoRowController"];
    
    for (NSInteger i = 0; i < self.allTodos.count; i++) {
        TodoRowController *rowController = [self.table rowControllerAtIndex:i];
        [rowController. titleLabel setText:self.allTodos[i].title];
        [rowController.contentLabel setText:self.allTodos[i].content];
    }
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    NSDictionary *toDoDictionary = @{@"title":self.allTodos[rowIndex].title, @"content":self.allTodos[rowIndex].content};
    
    [self pushControllerWithName:@"DetailToDoInterfaceController" context:toDoDictionary];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [[WCSession defaultSession] setDelegate:self];
    [[WCSession defaultSession] activateSession];
    
    //The message parameter is where you would want to hand the iOS app new Todo data to save to Firebase
    [[WCSession defaultSession] sendMessage:@{} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSArray *todoDictionaries = replyMessage [@"todos"];
        
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
        
        for (NSDictionary *todoObject in todoDictionaries) {
            Todo *newTodo = [[Todo alloc] init];
            newTodo.title = todoObject[@"title"];
            newTodo.content = todoObject[@"content"];
            
            [allTodos addObject:newTodo];
        }
        
        self.allTodos = allTodos.copy;
        [self setupTable];
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        
    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

//-tableview did select row at index path

@end



