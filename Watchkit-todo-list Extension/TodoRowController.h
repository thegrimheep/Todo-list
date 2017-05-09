//
//  TodoRowController.h
//  Todo-list
//
//  Created by David Porter on 5/9/17.
//  Copyright © 2017 David Porter. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WatchKit;

@interface TodoRowController : NSObject
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end
