//
//  Todo.m
//  ToDoList
//
//  Created by Brian Vo on 2018-04-24.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithFullDetails:(NSString *)title toDoDescription:(NSString *)toDoDescription priorityNumber:(NSNumber *) priorityNumber isComplete:(BOOL) isComplete
{
    self = [super init];
    if (self) {
        _title = title;
        _toDoDescription = toDoDescription;
        _prioityNumber = priorityNumber;
        _isComplete = isComplete;
    }
    return self;
}

@end
