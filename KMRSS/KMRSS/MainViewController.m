//
//  MainViewController.m
//  KMRSS
//
//  The MIT License
//
//  Copyright (c)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of 
//  this software and associated documentation files (the "Software"), to deal in 
//  the Software without restriction, including without limitation the rights to use, 
//  copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the 
//  Software, and to permit persons to whom the Software is furnished to do so, subject 
//  to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all 
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS 
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF 
//  OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "MainViewController.h"

@implementation MainViewController
@synthesize dataArray = _dataArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set the navigation bar title
    self.title = @"Feed";
    
    /* Create the parser and initialize with the feed URL. The URL must start with http:// . If it starts
    with feed:// change it to http:// */
    KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:@"http://feeds.bbci.co.uk/news/rss.xml"];
    parser.parserDelegate = self;
    //To get the result and store it in an array call the parser 'posts' method
    self.dataArray = [parser posts];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    // Get the title and summary from the array and display
    // You can get the date the content was published using the 'date' key
    cell.textLabel.text = [NSString stringWithFormat:@"Title: %@", [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Summary: %@", [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"summary"]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //This will open the URL in Safari. You can pass it to another view controller and open it in a UIWebView if you want
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"link"]]];
}

#pragma mark - Parser delegate

- (void)parserDidFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)parserCompletedSuccessfully
{
    NSLog(@"Parse complete. You may need to reload the table view to see the data.");
}

@end
