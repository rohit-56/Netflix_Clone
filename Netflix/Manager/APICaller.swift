//
//  APICaller.swift
//  Netflix
//
//  Created by Rohit Sharma on 12/12/22.
//

import Foundation
import UIKit



class APICaller{
    
    static let shared = APICaller()
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.Base_Url)movie/upcoming?api_key=\(Constants.API_Key)&language=en-US&page=1")  else {return}
      
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.Base_Url)trending/movie/day?api_key=\(Constants.API_Key)")  else {return}
      
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.Base_Url)trending/tv/day?api_key=\(Constants.API_Key)")  else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.Base_Url)movie/top_rated?api_key=\(Constants.API_Key)&language=en-US&page=1")  else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.Base_Url)movie/popular?api_key=\(Constants.API_Key)&language=en-US&page=1")  else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title],Error>) -> Void ){
        guard let url = URL(string: "\(Constants.Base_Url)discover/movie?api_key=\(Constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_ ,error  in
            
            guard let data = data , error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func getSearchQueryResults(with query : String , completion: @escaping (Result<[Title],Error>) -> Void ){
        
        guard  let queryRequest = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.Base_Url)search/movie?api_key=\(Constants.API_Key)&query=\(queryRequest)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_ ,error  in
            
            guard let data = data , error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    func getYoutubeResponseForSearchQuery(with query : String , completion: @escaping (Result<VideoResponse,Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.YouTube_Base_Url)/search?q=\(query)&key=\(Constants.YouTube_API_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ (data,_,error) in
            guard let data = data , error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                completion(.success(results.items[0]))
            }catch{
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
