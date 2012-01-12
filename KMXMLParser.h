//
//  KMXMLParser.h
//  KMXMLClass
//
//  Created by Kieran McGrady http://www.kieranmcgrady.com
//  Twitter: http://twitter.com/kmcgrady
//
//  You can use this code freely in any project commercial and non-
//  commercial. You must retain this header.

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
