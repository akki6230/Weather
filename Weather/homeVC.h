//
//  homeVC.h
//  Weather
//
//  Created by Anoop Gupta on 23/06/15.
//  Copyright (c) 2015 Ankit Neo GHz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeVC : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableViewToday;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrent;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewWether;
@property (strong, nonatomic) IBOutlet UILabel *lblToday;
@property (strong, nonatomic) IBOutlet UILabel *lblWeekDays;
@property (strong, nonatomic) IBOutlet UILabel *lblFav;

@end
