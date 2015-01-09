//
//  ViewController.m
//  Exm_RSSparser
//
//  Created by Admin on 08.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    
    NSMutableString *pubDate;
    NSMutableArray *imageArray;
    
    NSString *element;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    feeds = [[NSMutableArray alloc] init];
    
  //  NSURL *url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    // http://feeds.feedburner.com/euronews/ru/home/
 //   NSURL *url = [NSURL URLWithString:@"http://feeds.feedburner.com/euronews/ru/home/"];
    // http://ria.ru/export/rss2/economy/index.xml
  //  NSURL *url = [NSURL URLWithString:@"http://ria.ru/export/rss2/economy/index.xml"];
    NSURL *url = [NSURL URLWithString:@"http://appleinsider.ru/feed"];
    
    // feed://appleinsider.ru/feed
    
    
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    if (!myCell) {
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    UILabel *nameLabel = (UILabel*)[myCell viewWithTag:100];
    nameLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    UILabel *pubDateLabel = (UILabel*) [myCell viewWithTag:101];
    pubDateLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"pubDate"];

    return myCell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        
        pubDate = [[NSMutableString alloc] init];
        imageArray = [[NSMutableArray alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"] ) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        
        [item setObject:pubDate forKey:@"pubDate"];
        [item setObject:imageArray forKey:@"image"];
        
        [feeds addObject:[item copy]];
    }
    else if ([elementName isEqualToString:@"enclosure"]) {
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    else if ([element isEqualToString:@"pubDate"]) {
        [pubDate appendString:string];
    }
    else if ([element isEqualToString:@"image"]) {
        [imageArray addObject:string]; // add image URL String
    }
    else if ([element isEqualToString:@"description"]) {
        [imageArray addObject:string]; // add image URL String
    }
    else if([element isEqualToString:@"enclosure"])
    {
    //    NSString *urlValue=[attributeDict valueForKey:@"url"];
     //   NSString *urlValue=[attributeDict valueForKey:@"type"];
     //   NSString *urlValue=[attributeDict valueForKey:@"length"];
    }

}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailController"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
         [[segue destinationViewController] setUrl:string];
    }
}


@end
