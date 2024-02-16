//
//  News.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 15/02/24.
//

import Foundation

class News {
    var url: URL
    var stories = ""
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch(using session: URLSessionProtocol = URLSession.shared, completionHandler: @escaping () -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.stories = String(decoding: data, as: UTF8.self)
            }
            
            completionHandler()
        }
        
        task.resume()
    }
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class DataTaskMock: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    var resumeWasCalled = false
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        resumeWasCalled = true
        completionHandler(nil, nil, nil)
    }
}

class URLSessionMock: URLSessionProtocol {
    var dataTask : DataTaskMock?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let newDataTask = DataTaskMock(completionHandler: completionHandler)
        dataTask = newDataTask
        return newDataTask
    }
    
}

