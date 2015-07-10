//
//  homeVC.m
//  Weather
//
//  Created by Ankit Neo GHz on 23/06/15.
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
                
            // location name
            _lblLocationName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
              
             // current temp
            _lblCurrentTemp.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"main"] objectForKey:@"temp"]];
            _lblCurrentTemp.text = [NSString stringWithFormat:@"%@",[self getTempInCelciusFromKelvin:_lblCurrentTemp.text]];
              
            // Maximum temp
            _lblTempMax.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"main"] objectForKey:@"temp_max"]];
            _lblTempMax.text = [NSString stringWithFormat:@"%@",[self getTempInCelciusFromKelvin:_lblTempMax.text]];
                
             // Minimum temp
            _lblTempMin.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"main"] objectForKey:@"temp_min"]];
            _lblTempMin.text = [NSString stringWithFormat:@"%@",[self getTempInCelciusFromKelvin:_lblTempMin.text]];
              
             // visibility
            _lblVisibility.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"visibility"]];
            NSInteger intVis = [_lblVisibility.text integerValue]/ 1000;
            _lblVisibility.text = [NSString stringWithFormat:@"%ld%@",intVis,@" km"];
               
              // humidity
            _lblHumidity.text = [NSString stringWithFormat:@"%@%@",[[dic objectForKey:@"main"] objectForKey:@"humidity"], @" %"];
            _lblWInd.text = [NSString stringWithFormat:@"%@%@",[[dic objectForKey:@"wind"] objectForKey:@"speed"],@"kmph"];
            
                // sunrise time
           _lblsunrise.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"sys"] objectForKey:@"sunrise"]];
            _lblsunrise.text = [NSString stringWithFormat:@"%@%@",[self getDateFromUnixFormat:_lblsunrise.text], @" am"];
             
            // sunset time
             _lblSunset.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"sys"] objectForKey:@"sunset" ]];
             _lblSunset.text = [NSString stringWithFormat:@"%@%@",[self getDateFromUnixFormat:_lblSunset.text], @" pm"];
                
            
            }
            
        }];
        
    }];
    
}

// get Time
- (NSString *) getDateFromUnixFormat:(NSString *)unixFormat
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[unixFormat intValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy-h:mm"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dte=[dateFormatter stringFromDate:date];
    
    NSArray *arrTime = [dte componentsSeparatedByString:@"-"];
    
    return [arrTime objectAtIndex:1];
    
}

// get Temp
-(NSString *)getTempInCelciusFromKelvin:(NSString *)tempKelvin
{
    NSInteger temp = [tempKelvin integerValue] - 273.15;
    return [NSString stringWithFormat:@"%ld",temp];
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
