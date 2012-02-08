//
//  MainViewController.m
//  KMRSS
//
//  Created by Kieran McGrady on 13/01/2012.
//

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
