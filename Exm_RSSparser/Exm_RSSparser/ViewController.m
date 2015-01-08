//
//  ViewController.m
//  Exm_RSSparser
//
//  Created by Admin on 08.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    
    NSString *element;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    feeds = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [feeds count];
   // return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    if (!myCell) {
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    
    myCell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    
    return myCell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"] ) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        
        [feeds addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}




/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([[segue identifier] isEqualToString:@"showDetail"]) {
 
 NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
 NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
 [[segue destinationViewController] setUrl:string];

 */

@end
