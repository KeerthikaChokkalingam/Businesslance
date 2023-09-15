//
//  CredentialsViewModel.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import Foundation
import UIKit

protocol ResponseParserDelegate: AnyObject {
    func passSuccesResponse(responseResult:CredentialResponse)
    func passError(errorResult: Int)
}

class CredentialsViewModel: NSObject {
    
    var delegateInitVar: ResponseParserDelegate?
    
    func getBusinessDetails<T:Codable>(param: [String:Any], type: T.Type){
        let apiUrl = URL(string: "https://www.demo.progressive-solution.com/Projects/carwash_app/Api/business.json")!
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        
        
        if let postData = try? JSONSerialization.data(withJSONObject: param) {
            request.httpBody = postData
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("PHPSESSID=981fae4a4ab9aee371f8750300918806", forHTTPHeaderField: "Cookie")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                if self.delegateInitVar != nil {
                    // 500 - local error
                    self.delegateInitVar?.passError(errorResult: 500)
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    // Successful response
                    if let data = data {
                        // Parse and process the response data (e.g., JSON decoding)
                        do {
                            let person = try JSONDecoder().decode(T.self, from: data )
                            if self.delegateInitVar != nil {
                                self.delegateInitVar?.passSuccesResponse(responseResult: person as! CredentialResponse)
                            }
                        } catch {
                            if self.delegateInitVar != nil {
                                // 300 - decode error
                                self.delegateInitVar?.passError(errorResult: 300)
                            }
                            print("Error decoding JSON: \(error)")
                        }
                    }
                } else {
                    // Handle non-successful response (e.g., error messages)
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if self.delegateInitVar != nil {
                        // 400 - non-successful response
                        self.delegateInitVar?.passError(errorResult: 400)
                    }
                }
            }
        }
        task.resume()
    }
    
    func applyResultIntoUI() {
        
    }
}
