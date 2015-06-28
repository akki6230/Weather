//
//  homeVC.m
//  Weather
//
//  Created by Anoop Gupta on 23/06/15.
//  Copyright (c) 2015 Ankit Neo GHz. All rights reserved.
//

#import "homeVC.h"

@interface homeVC ()

@end

@implementation homeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // work for lat long
    loctaionManager = [CLLocationManager new];
    loctaionManager.delegate = self;
    loctaionManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    loctaionManager.distanceFilter = kCLDistanceFilterNone;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [loctaionManager requestAlwaysAuthorization];
        [loctaionManager requestWhenInUseAuthorization];
    }

        [loctaionManager startUpdatingLocation];
    
    
    _scrollViewWether.scrollEnabled =YES;
    _scrollViewWether.contentSize = CGSizeMake(_scrollViewWether.frame.size.width * 4, _scrollViewWether.frame.size.height);
    
    // Do any additional setup after loading the view.
}

#pragma mark - CoreLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Current location = %@",newLocation);
    
    CLLocation *currentLocation;
    
    CLGeocoder *geoCoder = [CLGeocoder new];
    currentLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
       // NSLog(@"placemark %@",placemark);
        //String to hold address
       // NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//        NSLog(@"addressDictionary %@", placemark.addressDictionary);
//        NSLog(@"placemark %@",placemark.country);  // Give Country Name
//        NSLog(@"placemark %@",placemark.locality); // Extract the city name
        
        NSString *strLati = [NSString stringWithFormat:@"%.8f",newLocation.coordinate.latitude];
        NSString *strLong = [NSString stringWithFormat:@"%.8f",newLocation.coordinate.longitude];
        
        _lblLocationName.text = placemark.locality;
        
        weatherObjectAPI *weatherObj = [[weatherObjectAPI alloc] init];
        [weatherObj getCurrentWeatherWithlattitude:strLati longitude:strLong competionHandler:^(NSDictionary *dic, NSError *error) {
            if (!error)
            {
            _lblCurrentTemp.text = [[dic objectForKey:@"main"] objectForKey:@"temp"];
            _lblTempMax.text = [[dic objectForKey:@"main"] objectForKey:@"temp_max"];
            _lblTempMin.text = [[dic objectForKey:@"main"] objectForKey:@"temp_min"];
            _lblVisibility.text = [dic objectForKey:@"visibility"];
                
            _lblHumidity.text = [[dic objectForKey:@"main"] objectForKey:@"humidity"];
            //_lblVisibility.text = [[dic objectForKey:@"main"] ;
            _lblWInd.text = [[dic objectForKey:@"main"] objectForKey:@"temp"];
           // _lblsunrise.text = [[dic objectForKey:@"sys"] objectForKey:@"temp"];
           // _lblSunset.text = [[dic objectForKey:@"sys"] objectForKey:@"temp"];
                
            }
            
        }];
        
    }];
    
}
#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollViewWether.contentOffset.x == 0)
    {
        _lblCurrent.backgroundColor = [UIColor lightGrayColor];
        _lblToday.backgroundColor = [UIColor grayColor];
         _lblWeekDays.backgroundColor = [UIColor grayColor];
         _lblFav.backgroundColor = [UIColor grayColor];
    }
    else if (_scrollViewWether.contentOffset.x == _scrollViewWether.frame.size.width)
    {
        _lblCurrent.backgroundColor = [UIColor grayColor];
        _lblToday.backgroundColor = [UIColor lightGrayColor];
        _lblWeekDays.backgroundColor = [UIColor grayColor];
        _lblFav.backgroundColor = [UIColor grayColor];
        
    }
    else if (_scrollViewWether.contentOffset.x == _scrollViewWether.frame.size.width * 2)
    {
        _lblCurrent.backgroundColor = [UIColor grayColor];
        _lblToday.backgroundColor = [UIColor grayColor];
        _lblWeekDays.backgroundColor = [UIColor lightGrayColor];
        _lblFav.backgroundColor = [UIColor grayColor];
    }
    else if (_scrollViewWether.contentOffset.x == _scrollViewWether.frame.size.width * 3)
    {
        _lblCurrent.backgroundColor = [UIColor grayColor];
        _lblToday.backgroundColor = [UIColor grayColor];
        _lblWeekDays.backgroundColor = [UIColor grayColor];
        _lblFav.backgroundColor = [UIColor lightGrayColor];
    }

}

#pragma  mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *strCellID = @"CELLID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:strCellID forIndexPath:indexPath];
    
    UILabel *lblSeprator = [[UILabel alloc] initWithFrame:CGRectMake(15, cell.frame.size.height - 10, cell.frame.size.width - 15, 10)];
    lblSeprator.backgroundColor = [UIColor lightTextColor];
    [cell.contentView addSubview:lblSeprator];
    
    return cell;
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
