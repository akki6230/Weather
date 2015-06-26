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
    
    _scrollViewWether.scrollEnabled =YES;
    _scrollViewWether.contentSize = CGSizeMake(_scrollViewWether.frame.size.width * 4, _scrollViewWether.frame.size.height);
    
    // Do any additional setup after loading the view.
}

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
