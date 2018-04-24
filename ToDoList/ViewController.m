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
#import "DetailViewController.h"
#import "AddTodoViewController.h"

@interface ViewController () <AddTodoViewControllerDelegate>

@property (nonatomic) NSMutableArray <ToDo *> *toDoArray;
@property (nonatomic) NSMutableArray <ToDo *> *completedTasksArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    ToDo *firstToDo = [[ToDo alloc] initWithFullDetails:@"Drive" toDoDescription:@"Drive kids to school" priorityNumber:[NSNumber numberWithInt: 100] isComplete:NO];
    ToDo *secondToDo = [[ToDo alloc] initWithFullDetails:@"Work" toDoDescription:@"Go to work" priorityNumber:[NSNumber numberWithInt: 90] isComplete:NO];
    ToDo *thirdToDo = [[ToDo alloc] initWithFullDetails:@"Pick Up Kids" toDoDescription:@"Pick up kids from school" priorityNumber:[NSNumber numberWithInt: 98] isComplete:NO];
    ToDo *fourthToDo = [[ToDo alloc] initWithFullDetails:@"Cook" toDoDescription:@"Cook food for family" priorityNumber:[NSNumber numberWithInt: 75] isComplete:NO];
    ToDo *fifthToDo = [[ToDo alloc] initWithFullDetails:@"Relax" toDoDescription:@"Take a break and relax for the day" priorityNumber:[NSNumber numberWithInt: 50] isComplete:NO];
    
    self.toDoArray = [[NSMutableArray alloc] initWithObjects:
                      firstToDo,
                      secondToDo,
                      thirdToDo,
                      fourthToDo,
                      fifthToDo,
                      nil];
    
    self.completedTasksArray = [[NSMutableArray alloc] init];
    
}

-(void)addTodo:(ToDo *)todo {
    [self.toDoArray addObject:todo];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.toDoArray count];
    }
    else {
        return [self.completedTasksArray count];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ToDoCell *cell = (ToDoCell *)[tableView dequeueReusableCellWithIdentifier:@"TodoId"];
    ToDo *todo;
    
    if (indexPath.section == 0) {
        
        todo = (self.toDoArray)[indexPath.row];
    }
    else {
        
        todo = (self.completedTasksArray)[indexPath.row];
    }
    cell.titleLabel.text = todo.title;
    cell.descriptionLabel.text = todo.toDoDescription;
    cell.priortyLabel.text = [NSString stringWithFormat:@"%@", todo.prioityNumber];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"todoDetailsId" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"todoDetailsId"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.todo = [self.toDoArray objectAtIndex:indexPath.row];
    }
    if ([segue.identifier isEqualToString:@"addButtonId"]) {
        AddTodoViewController *addVC = [segue destinationViewController];
        addVC.delegate = self;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ( section == 0)
        return @"Incomplete Tasks";
    else
        return @"Completed Tasks";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *completeTaskAction = [UITableViewRowAction
                                                rowActionWithStyle:UITableViewRowActionStyleDefault
                                                title:@"Complete Task"
                                                handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                    
                                                    NSLog(@"is complete");
                                                    
                                                    ToDo *task = [self.toDoArray objectAtIndex:indexPath.row];
                                                    
                                                    NSLog(@"todo title %@", task.title);
                                                    
                                                    task.isComplete = YES;
                                                    
                                                    [self.completedTasksArray addObject:task];
                                                    
                                                    [self.toDoArray removeObjectAtIndex:indexPath.row];
                                                    
                                                    [self.tableView reloadData];
                                                    
                                                }];
    
    completeTaskAction.backgroundColor = [UIColor greenColor];
    
    return @[completeTaskAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
