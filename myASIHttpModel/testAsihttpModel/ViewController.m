//
//  ViewController.m
//  testAsihttpModel
//
//  Created by wgdadmin on 12-9-8.
//  Copyright (c) 2012年 wgdadmin. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
@interface ViewController ()

@end

@implementation ViewController


-(void)getDate:(id)sender
{
//    NSString   *city = [NSString stringWithFormat:@"%@",nameField.text];
     NSString   *city = @"beijing";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true", city]];
    NSLog(@"city:%@",city);
    ASIHTTPRequest *request =[[[ASIHTTPRequest alloc] initWithURL:url]autorelease];
    request.delegate = self;
    [request startAsynchronous];
    
}

- (void)viewDidLoad
{
    UIButton    *mapBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
    [mapBtn setBackgroundColor:[UIColor greenColor]];
    [mapBtn setTitle:@"get" forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapBtn];
    [mapBtn release];   

    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *string = [request responseString];
////    NSDictionary *dic = [string JSONValue];
    NSDictionary    *dic = [string objectFromJSONString];
    
    NSArray  *result = [dic objectForKey:@"results"];
    
    NSArray  *componets = [[result objectAtIndex:0] objectForKey:@"address_components"];
    
    NSArray *types = [[componets objectAtIndex:0]objectForKey:@"types"];
    
    NSString *first = [types objectAtIndex:0];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tip" message:first delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    NSLog(@"string:%@",string);
}


-(void)dealloc
{
    [super dealloc];
}
@end
