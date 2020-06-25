//
//  APIBridge.swift
//  basic
//
//  Created by Nick Culpin on 6/24/20.
//  Copyright © 2020 basic. All rights reserved.
//

import Foundation

@objc(APIBridge)
class APIBridge: NSObject {
    
    let api = API()
    
    @objc func download(_ searchTerm: NSString, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        api.download(searchTerm: searchTerm as String) { results, errorMessage in
            if let results = results {
                resolve(results)
            } else {
                let error = NSError()
                reject("error", errorMessage, error as Error);
            }
        }
    }

}
