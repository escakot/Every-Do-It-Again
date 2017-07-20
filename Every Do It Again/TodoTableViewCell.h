//
//  TodoTableViewCell.h
//  Every Do It Again
//
//  Created by Errol Cheong on 2017-07-19.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo+CoreDataProperties.h"

@interface TodoTableViewCell : UITableViewCell

@property (strong, nonatomic) Todo* todo;

@end
