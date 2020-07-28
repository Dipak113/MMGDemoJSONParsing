//
//  ServerManager.swift
//  MMagicJsonParsing
//
//  Created by Dipak Dhondge on 28/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import Foundation

class ServerManager: NSObject {

    static let sharedInstance = ServerManager()
    
////////////////////////////////////////////////////////////////////
/// Function to get articles from server
///   - handler: handler to provide results back to view model
/////////////////////////////////////////////////////////////////////
    
    func getArticleListFromServer(handler:@escaping ([ListModel]?, Error?)->Void) {
        
        //create the url with URL //https://picsum.photos/list
        if let url = URL(string: "https://picsum.photos/list") {

            //create the session object
            let session = URLSession.shared

            //now create the URLRequest object using the url object
            let request = URLRequest(url: url)

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    handler(nil, error)
                    return
                }

                guard let data = data else {
                    return
                }

               do {
                  // data we are getting from network request
                let decoder = JSONDecoder()
                let response = try decoder.decode([ListModel].self, from: data)
                handler(response,nil)
               } catch let error {
                handler(nil, error)
               }
            })
            task.resume()
        }

    }
}

