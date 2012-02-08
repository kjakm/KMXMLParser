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

@protocol KMXMLParserDelegate <NSObject>

- (void)parserDidFailWithError:(NSError *)error;
- (void)parserCompletedSuccessfully;

@end

@interface KMXMLParser : NSObject <NSXMLParserDelegate>{

	NSXMLParser *parser;
	NSMutableArray *posts;
	NSMutableDictionary *elements;
	NSString *element;
	NSMutableString *title;
	NSMutableString *date;
	NSMutableString *summary;
	NSMutableString *link;
    
    id <KMXMLParserDelegate> parserDelegate;
}

@property (strong, nonatomic) id <KMXMLParserDelegate> parserDelegate;

- (id)initWithURL:(NSString *)url;
- (void)beginParsing:(NSURL *)xmlURL;
- (NSMutableArray *)posts;
@end
