//
//  FirebaseAPI.h
//  Todo-list
//
//  Created by David Porter on 5/10/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Todo.h"

typedef void(^AllTodosCompletion)(NSArray<Todo *> *allTodos);

@interface FirebaseAPI : NSObject

+(void)fetchAllTodos:(AllTodosCompletion)completion;

@end
