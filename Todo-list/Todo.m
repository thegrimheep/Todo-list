//
//  Todo.m
//  Todo-list
//
//  Created by David Porter on 5/11/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import "Todo.h"

@implementation Todo

-(instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content {
    self.title = title;
    self.content = content;
    
    return self;
}

@end
