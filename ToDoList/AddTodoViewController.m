//
//  AddTodoViewController.m
//  ToDoList
//
//  Created by Brian Vo on 2018-04-24.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)submitDetails:(id)sender {
    ToDo *todo = [[ToDo alloc] initWithFullDetails:self.titleTextField.text
                                   toDoDescription:self.descriptionTextField.text
                                    priorityNumber: [NSNumber numberWithInteger:self.prioityTextField.text.integerValue]
                                        isComplete:NO];
    
    self.titleTextField.text = @"";
    self.descriptionTextField.text = @"";
    self.prioityTextField.text = @"";
    
    [self.delegate addTodo:todo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
