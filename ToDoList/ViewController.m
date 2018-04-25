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
@property (nonatomic) NSArray <ToDo *> *sortedTodoArray;
@property (nonatomic) NSMutableArray <ToDo *> *completedTasksArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDate *date = [NSDate date];
    
    ToDo *firstToDo = [[ToDo alloc] initWithFullDetails:@"Drive" toDoDescription:@"Drive kids to school" priorityNumber:[NSNumber numberWithInt: 100] isComplete:NO date:date];
    ToDo *secondToDo = [[ToDo alloc] initWithFullDetails:@"Work" toDoDescription:@"Go to work" priorityNumber:[NSNumber numberWithInt: 90] isComplete:NO date:date];
    ToDo *thirdToDo = [[ToDo alloc] initWithFullDetails:@"Pick Up Kids" toDoDescription:@"Pick up kids from school" priorityNumber:[NSNumber numberWithInt: 98] isComplete:NO date:date];
    ToDo *fourthToDo = [[ToDo alloc] initWithFullDetails:@"Cook" toDoDescription:@"Cook food for family" priorityNumber:[NSNumber numberWithInt: 75] isComplete:NO date:date];
    ToDo *fifthToDo = [[ToDo alloc] initWithFullDetails:@"Relax" toDoDescription:@"Take a break and relax for the day" priorityNumber:[NSNumber numberWithInt: 50] isComplete:NO date:date];
    
    self.toDoArray = [[NSMutableArray alloc] initWithObjects:
                      firstToDo,
                      secondToDo,
                      thirdToDo,
                      fourthToDo,
                      fifthToDo,
                      nil];
    
    self.sortedTodoArray = [self.toDoArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(ToDo*)a prioityNumber];
        NSNumber *second = [(ToDo*)b prioityNumber];
        return [second compare:first];
    }];
    
    self.completedTasksArray = [[NSMutableArray alloc] init];
    
}




- (IBAction)editTapped:(id)sender {
    self.tableView.editing = !self.tableView.editing;
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
        
//        todo = (self.toDoArray)[indexPath.row];
        todo = (self.sortedTodoArray)[indexPath.row];
    }
    else {
        
        todo = (self.completedTasksArray)[indexPath.row];
    }
    cell.titleLabel.text = todo.title;
    cell.descriptionLabel.text = todo.toDoDescription;
    cell.priortyLabel.text = [NSString stringWithFormat:@"%@", todo.prioityNumber];
    cell.dateLabel.text = [NSDateFormatter localizedStringFromDate:todo.date
                                                         dateStyle:NSDateFormatterShortStyle
                                                         timeStyle:NSDateFormatterShortStyle];
    
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
                                                    
                                                    ToDo *task = [self.toDoArray objectAtIndex:indexPath.row];
                                                    
                                                    task.isComplete = YES;
                                                    
                                                    [self.completedTasksArray addObject:task];
                                                    
                                                    [self.toDoArray removeObjectAtIndex:indexPath.row];
                                                    
                                                    [self.tableView reloadData];
                                                    
                                                }];
    UITableViewRowAction *deleteAction = [UITableViewRowAction
                                                rowActionWithStyle:UITableViewRowActionStyleDefault
                                                title:@"Delete"
                                                handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                    
                                                    [self.toDoArray removeObjectAtIndex:indexPath.row];
                                                    
                                                    [self.tableView reloadData];
                                                    
                                                }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    completeTaskAction.backgroundColor = [UIColor greenColor];
    
    return @[deleteAction, completeTaskAction];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    ToDo *todo;
    
    if (sourceIndexPath.section == 0) {
        todo = [self.toDoArray objectAtIndex:sourceIndexPath.row];
        [self.toDoArray removeObjectAtIndex:sourceIndexPath.row];
    } else {
        todo = [self.completedTasksArray objectAtIndex:sourceIndexPath.row];
        [self.completedTasksArray removeObjectAtIndex:sourceIndexPath.row];
    }
    
    if (destinationIndexPath.section == 0) {
        [self.toDoArray insertObject:todo atIndex:destinationIndexPath.row];
    }
    else {
        [self.completedTasksArray insertObject:todo atIndex:destinationIndexPath.row];
    }
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
