//
//  Todo.h
//  ToDoList
//
//  Created by Brian Vo on 2018-04-24.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *toDoDescription;
@property (nonatomic) NSNumber *prioityNumber;
@property (nonatomic) BOOL isComplete;

- (instancetype)initWithFullDetails:(NSString *)title toDoDescription:(NSString *)toDoDescription priorityNumber:(NSNumber *) priorityNumber isComplete:(BOOL) isComplete;

@end
