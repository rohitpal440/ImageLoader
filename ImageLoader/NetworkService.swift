//
//  NetworkService.swift
//  ImageLoader
//
//  Created by Rohit Pal on 11/08/16.
//  Copyright © 2016 Rohit Pal. All rights reserved.
//

import Foundation

class NetworkService{
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    let url: NSURL
    init(url:NSURL){
        self.url = url
        print(url.absoluteURL)
    }
    
    func fetchImage(completion: (NSData -> Void)){
        let request = NSURLRequest(URL: self.url)
        let dataTask = session.dataTaskWithRequest(request){ (data, response, error) in
            if error == nil {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch(httpResponse.statusCode){
                    case 200:
                        print("Status Code : " + String(httpResponse.statusCode))
                        if let data = data {
                            completion(data)
                        }
                    default:
                        print("Status Code : " + String(httpResponse.statusCode))
                    }
                }
                
            } else {
                print("Error in Downloading the image \(error?.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}