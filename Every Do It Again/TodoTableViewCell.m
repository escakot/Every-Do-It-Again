//
//  TodoTableViewCell.m
//  Every Do It Again
//
//  Created by Errol Cheong on 2017-07-19.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "TodoTableViewCell.h"


@interface TodoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *todoDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *priorityView;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@end

@implementation TodoTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    UIColor *color = self.priorityView.backgroundColor;
    if (selected){
        self.priorityView.backgroundColor = color;
    }
}

-(void)setTodo:(Todo *)todo
{
    if (self.todo.isCompleted){
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:self.todo.title];
        [attributedTitle addAttribute:NSStrikethroughStyleAttributeName
                                 value:@1
                                 range:NSMakeRange(0, attributedTitle.length)];
        self.titleLabel.attributedText = attributedTitle;
        NSMutableAttributedString *attributedDescription = [[NSMutableAttributedString alloc] initWithString:self.todo.todoDescription];
        [attributedDescription addAttribute:NSBaselineOffsetAttributeName
                                      value:@0
                                      range:NSMakeRange(0, attributedDescription.length)];
        [attributedDescription addAttribute:NSStrikethroughStyleAttributeName
                                 value:@1
                                 range:NSMakeRange(0, attributedDescription.length)];
        self.todoDescriptionLabel.attributedText = attributedDescription;
    } else {
        self.titleLabel.text = self.todo.title;
        self.todoDescriptionLabel.text = self.todo.todoDescription;
    }
    //Priority color
    NSArray<UIColor*>* priorityColors = @[[UIColor greenColor],
                                          [UIColor yellowColor],
                                          [UIColor orangeColor],
                                          [UIColor redColor]];
    self.priorityView.backgroundColor = priorityColors[self.todo.priority];
    self.priorityView.layer.cornerRadius = 30/2;
    
    //Deadline Date
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    unsigned dateFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComps = [gregorian components:dateFlags fromDate:self.todo.deadline];
    NSDate *dateOnly = [gregorian dateFromComponents:dateComps];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"MMM dd"];
    self.deadlineLabel.text = [formatter stringFromDate:dateOnly];
}



@end
