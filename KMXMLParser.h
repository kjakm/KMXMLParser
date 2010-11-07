//
//  KMXMLParser.h
//  KMXMLClass
//
//  Created by Kieran McGrady http://www.kieranmcgrady.me
//

#import <Foundation/Foundation.h>


@interface KMXMLParser : NSObject <NSXMLParserDelegate>{

	NSXMLParser *parser;
	NSMutableArray *posts;
	NSMutableDictionary *elements;
	NSString *element;
	NSMutableString *title;
	NSMutableString *date;
	NSMutableString *summary;
	NSMutableString *link;
	
}

-(void)parseURL:(NSString *)URL;
-(void)beginParsing:(NSURL *)xmlURL;
-(NSMutableArray *)posts;
@end
