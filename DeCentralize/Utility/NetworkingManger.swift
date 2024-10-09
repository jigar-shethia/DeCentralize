//
//  NetworkingManger.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 06/10/24.
//

import Foundation
import Combine

class NetworkingManger {
    enum NetworkingError: LocalizedError {
        case badURLRespose(url: URL)
        case unknwn
        
        var errorDescription: String?{
            switch self{
            case .badURLRespose(url:let url): return "[🔥]Bad reponse from URL: \(url)"
            case .unknwn: return "[⚠️]Unknown error occured"
            }
        }
    }
 
 
    static func download(url: URL) -> AnyPublisher<Data, Error>   {
        return  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handlURLReponse(output:$0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    
    }
    static func handlURLReponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{ 
        guard let reponse = output.response as? HTTPURLResponse,
              reponse.statusCode >= 200 && reponse.statusCode < 300 else {
            throw NetworkingError.badURLRespose(url: url)
        }
        return output.data
    }
        
    static func completionBlock(completion: Subscribers.Completion<Error> ){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
    
}
