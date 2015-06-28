//
//  weatherObjectAPI.h
//  Weather
//
//  Created by Anoop Gupta on 26/06/15.
//  Copyright (c) 2015 Ankit Neo GHz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherObjectAPI : NSObject
{
    NSDictionary *dicToPass;
    NSData *dataResponse;
}
-(void)getCurrentWeatherWithlattitude:(NSString *)lat longitude:(NSString *)lon competionHandler:(void(^)(NSDictionary *dic, NSError *error))handler;

@end
