//
//  AddTodoViewController.h
//  ToDoList
//
//  Created by Brian Vo on 2018-04-24.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@protocol AddTodoViewControllerDelegate

-(void)addTodo:(ToDo *)todo;

@end

@interface AddTodoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *prioityTextField;

@property (weak, nonatomic) id <AddTodoViewControllerDelegate> delegate;


@end
