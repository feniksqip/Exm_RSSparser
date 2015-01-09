//
//  DetailViewController.m
//  Exm_RSSparser
//
//  Created by Admin on 09.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize url;
@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *myURL = [[NSURL alloc] initWithString: [self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *myURL = [NSURL URLWithString:[self.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
  //  NSURL *myURL = [NSURL URLWithString: [self.url stringByAddingPercentEscapesUsingEncoding:
   //                                       NSUTF8StringEncoding]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:myURL];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   // [segue de]
}
*/

@end
