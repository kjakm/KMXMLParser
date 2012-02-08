//
//  KMXMLParser.h
//  KMXMLClass
//
//  Created by Kieran McGrady http://www.kieranmcgrady.com
//  Twitter: http://twitter.com/kmcgrady
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
