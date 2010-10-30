//
//  KMXMLParser.m
//  KMXMLClass
//
//  Created by Kieran McGrady http://www.kieranmcgrady.me
//

#import "KMXMLParser.h"


@implementation KMXMLParser

- (void)parseURL:(NSString *)url
{
	//Create NSURL from given string
	NSURL *xmlURL = [NSURL URLWithString:url];
	[self beginParsing:xmlURL];
}

-(void)beginParsing:(NSURL *)xmlURL
{
	//Initialize variables
	posts = [[NSMutableArray alloc] init];
	parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	[parser setDelegate:self];
	
	//These can be modified depending on what you are parsing
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	
	//Begin parsing operation
	[parser parse];
	
}

-(NSMutableArray *)posts
{
	return posts;
}

#pragma mark NSXMLParser Delegate Methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	NSLog(@"Parsing has began");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	NSLog(@"Parsing complete");
	NSLog(@"You may need to reload your tableview to see changes");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	NSLog(@"ERROR OCCURED WHEN PARSING: %@", parseError.code);
	//Uncomment the following block of code to display an alert when an error occurs
	/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:@"An error occured when getting the data"
												   delegate:self
										  cancelButtonTitle:@"Dismiss"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];*/
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	element = [elementName copy];
	
	//If elementName == 'item' alloc and initalize dict and strings
	if ([elementName isEqualToString:@"item"]) 
	{
		elements = [[NSMutableDictionary alloc] init];
		title = [[NSMutableString alloc] init];
		date = [[NSMutableString alloc] init];
		summary = [[NSMutableString alloc] init];
		link = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
	//If elementName == 'item' save the values to the dictionary
	if ([elementName isEqualToString:@"item"]) 
	{
		[elements setObject:title forKey:@"title"];
		[elements setObject:date forKey:@"date"];
		[elements setObject:summary forKey:@"summary"];
		[elements setObject:link forKey:@"link"];
		
		[posts addObject:elements ];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	//Append the string the correct elements
	if ([element isEqualToString:@"title"]) 
	{
		[title appendString:string];
	} 
	else if ([element isEqualToString:@"pubDate"]) 
	{
		[date appendString:string];
	} 
	else if ([element isEqualToString:@"description"]) 
	{
		[summary appendString:string];
	} 
	else if ([element isEqualToString:@"link"]) 
	{
		[link appendString:string];
	} 
}


@end
