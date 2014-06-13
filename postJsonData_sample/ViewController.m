//
//  ViewController.m
//  postJsonData_sample
//
//  Created by Chang YuanYu on 2014/4/24.
//  Copyright (c) 2014年 James. All rights reserved.
//

#import "ViewController.h"

static NSString *const BaseURLString =
@"http://youtIP.php";

@interface ViewController ()
{
    NSMutableData *getResponseData;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadWebserverData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// use xcode kit
-(void) loadWebserverData
{
    
    NSURL *url = [NSURL URLWithString:BaseURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    NSString *jsonContent = @"hello world";
    // NSDictionary *parameters = @{@"data" : @"hello world"};
    //{"data" = "your message"}
    NSString *bodydata=[NSString stringWithFormat:@"data=%@",jsonContent];
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    
    
    [request setHTTPBody:req];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if( connection )
    {
        getResponseData = [NSMutableData new];
    }
}


// callback -NSURLConnection
-(void) connection:(NSURLConnection*) connetion didReceiveData:(NSData *)data
{
    [getResponseData appendData:data];
}

-(void) connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", [error localizedDescription]);
}

-(void) connectionDidFinishLoading:(NSURLConnection*) connection
{
    NSLog(@"請求完成");
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:getResponseData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"取得return資料: %@", dict);
}

@end
