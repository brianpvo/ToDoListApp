//
//  ViewController.m
//  ToDoList
//
//  Created by Brian Vo on 2018-04-24.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "ViewController.h"
#import "ToDo.h"
#import "ToDoCell.h"

@interface ViewController ()

@property (nonatomic) NSArray <ToDo *> *toDoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ToDo *firstToDo = [[ToDo alloc] initWithFullDetails:@"Drive" toDoDescription:@"Drive kids to school" priorityNumber:[NSNumber numberWithInt: 100] isComplete:NO];
    ToDo *secondToDo = [[ToDo alloc] initWithFullDetails:@"Work" toDoDescription:@"Go to work" priorityNumber:[NSNumber numberWithInt: 98] isComplete:NO];
    ToDo *thirdToDo = [[ToDo alloc] initWithFullDetails:@"Pick Up Kids" toDoDescription:@"Pick up kids from school" priorityNumber:[NSNumber numberWithInt: 99] isComplete:NO];
    ToDo *fourthToDo = [[ToDo alloc] initWithFullDetails:@"Cook" toDoDescription:@"Cook food for family" priorityNumber:[NSNumber numberWithInt: 75] isComplete:NO];
    ToDo *fifthToDo = [[ToDo alloc] initWithFullDetails:@"Relax" toDoDescription:@"Take a break and relax for the day" priorityNumber:[NSNumber numberWithInt: 50] isComplete:NO];
    
    self.toDoArray = [[NSArray alloc] initWithObjects:
                      firstToDo,
                      secondToDo,
                      thirdToDo,
                      fourthToDo,
                      fifthToDo,
                      nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.toDoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoCell *cell = (ToDoCell *)[tableView dequeueReusableCellWithIdentifier:@"TodoId"];
    
    ToDo *todo = (self.toDoArray)[indexPath.row];
    cell.titleLabel.text = todo.title;
    cell.descriptionLabel.text = todo.toDoDescription;
    cell.priortyLabel.text = [NSString stringWithFormat:@"%@", todo.prioityNumber];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end