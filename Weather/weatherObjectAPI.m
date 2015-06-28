//
//  weatherObjectAPI.m
//  Weather
//
//  Created by Ankit Neo GHz on 26/06/15.
//  Copyright (c) 2015 Ankit Neo GHz. All rights reserved.
//

// ?lat=35&lon=139
#import "weatherObjectAPI.h"
#import "AppUtility.h"
@implementation weatherObjectAPI

-(void)CallWebServices:(NSString *)url postDict:(NSString *)postDict :(void(^)(NSDictionary *dic, NSError *error))completionHandler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,postDict]]];
    
    NSURLConnection *con = [NSURLConnection connectionWithRequest:request delegate:self];
    if (con)
    {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
        NSLog(@"Success");
         dataResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:dataResponse options:kNilOptions error:nil];
        completionHandler (dicResponse,nil);
        });
    }
    else
    {
        NSLog(@"error");
    }
}

-(void)getCurrentWeatherWithlattitude:(NSString *)lat longitude:(NSString *)lon competionHandler:(void(^)(NSDictionary *dic, NSError *error))handler
{
    NSError *err;
    [self CallWebServices:[NSString stringWithFormat:@"%@",MAIN_URL] postDict:[NSString stringWithFormat:@"lat=%@&lon=%@&APPID=%@",lat,lon,API_KEY]:^(NSDictionary *dic, NSError *error)
    {
        dicToPass = [[NSDictionary alloc] initWithDictionary:dic];
        
    }];
    
    handler(dicToPass,err);
}

@end
