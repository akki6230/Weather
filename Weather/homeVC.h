//
//  homeVC.h
//  Weather
//
//  Created by Anoop Gupta on 23/06/15.
//  Copyright (c) 2015 Ankit Neo GHz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "weatherObjectAPI.h"
@interface homeVC : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *loctaionManager;
}
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentTemp;
@property (strong, nonatomic) IBOutlet UILabel *lblVisibility;
@property (strong, nonatomic) IBOutlet UILabel *lblTempMin;
@property (strong, nonatomic) IBOutlet UILabel *lblTempMax;
@property (strong, nonatomic) IBOutlet UILabel *lblLocationName;
@property (strong, nonatomic) IBOutlet UITableView *tableViewToday;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrent;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewWether;
@property (strong, nonatomic) IBOutlet UILabel *lblWInd;
@property (strong, nonatomic) IBOutlet UILabel *lblToday;
@property (strong, nonatomic) IBOutlet UILabel *lblWeekDays;
@property (strong, nonatomic) IBOutlet UILabel *lblFav;
@property (strong, nonatomic) IBOutlet UILabel *lblHumidity;
@property (strong, nonatomic) IBOutlet UILabel *lblsunrise;
@property (strong, nonatomic) IBOutlet UILabel *lblSunset;

@end
