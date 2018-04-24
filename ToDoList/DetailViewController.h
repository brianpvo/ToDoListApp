//
//  DetailViewController.h
//  ToDoList
//
//  Created by Brian Vo on 2018-04-24.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic) ToDo *todo;

@end
