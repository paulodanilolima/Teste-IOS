//
//  APIManager.swift
//  Teste IOS
//
//  Created by Paulo Danilo Conceição Lima on 08/08/21.
//

import Foundation

protocol APIManagerDelegate {
    func didUpdateApi(_ APIManager: APIManager, api: APIModel)
    func didFaildWithError(error: Error)
}

struct APIManager {
    let apiURL = "https://api.jsonbin.io/b/607db4d70ed6f819beb03020"
    
    var delegate: APIManagerDelegate?
    
    func fetchAPI(){
        let urlString = "https://api.jsonbin.io/b/607db4d70ed6f819beb03020"
        //print(urlString)
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String){
        
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFaildWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let api = self.parserJSON(safeData){
                        self.delegate?.didUpdateApi(self, api: api)
                    }
                }
            }
            
            task.resume()
        }
        
        
    }
    func parserJSON(_ apiData: Data) -> APIModel?{
        
        var isRead: [Bool] = []
        var id: [String] = []
        var content: [String] = []
        
        
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(APIData.self, from: apiData)
            
            
            
            for n in 0...decodeData.notifications.count - 1 {
                
                id.append(decodeData.notifications[n].id)
                isRead.append(decodeData.notifications[n].isRead)
                content.append(decodeData.notifications[n].content)
            }
            
            let api = APIModel(ID: id, isRead: isRead, content: content)
            
            return api
        }catch{
            delegate?.didFaildWithError(error: error)
            return nil
        }
    }
}
