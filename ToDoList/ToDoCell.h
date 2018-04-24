//
//  ToDoCell.h
//  ToDoList
//
//  Created by Brian Vo on 2018-04-24.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priortyLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
