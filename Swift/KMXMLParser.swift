//
//  KMXMLParser.swift
//  KMRSS
//
//  Created by Kieran McGrady on 04/06/2014.
//  Copyright (c) 2014 HotRod Software. All rights reserved.
//

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
                elements.setObject(summary, forKey: "summary") // Causing crash object cannot be nil
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