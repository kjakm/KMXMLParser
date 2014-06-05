//
//  KMXMLParser.swift
//  KMRSS
//
//  Created by Kieran McGrady on 04/06/2014.
//
//  The MIT License
//
//  Copyright Kieran McGrady(c)
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

import Foundation

class KMXMLParser: NSObject, NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title = NSMutableString()
    var date = NSMutableString()
    var summary = NSMutableString()
    var link = NSMutableString()

    func initWithURL(url :NSURL) -> AnyObject {
        beginParsing(url)
        return self
    }
    
    func beginParsing(xmlUrl :NSURL) {
        posts = []
        parser = NSXMLParser(contentsOfURL: xmlUrl)
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.delegate = self
        
        parser.parse()
    }
    
    func allPosts() -> NSMutableArray {
        return posts
    }
    
    // NSXMLParser Delegate
    
    func parserDidStartDocument(parser: NSXMLParser!) {
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        
    }
    
    func parser(_parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
            
    }
    
    func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI namespaceURI: String!, #qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        
        element = elementName
        
        if (elementName as NSString).isEqualToString("item") {
            elements = NSMutableDictionary.alloc()
            elements = [:]
            title = NSMutableString.alloc()
            title = ""
            date = NSMutableString.alloc()
            date = ""
            link = NSMutableString.alloc()
            link = ""
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, #namespaceURI: String!, qualifiedName qName: String!) {
        
        if (elementName as NSString).isEqualToString("item") {
            if title != nil {
                elements.setObject(title, forKey: "title")
            }
            if date != nil {
                elements.setObject(date, forKey: "date")
            }
            if summary != nil {
                elements.setObject(summary, forKey: "summary")
            }
            if link != nil {
                elements.setObject(link, forKey: "link")
            }
            
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if element.isEqualToString("title") {
            title.appendString(string)
        } else if element.isEqualToString("pubDate") {
            date.appendString(string)
        } else if element.isEqualToString("description") {
            summary.appendString(string)
        } else if element.isEqualToString("link") {
            link.appendString(string)
        }
    }
    
}