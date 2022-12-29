//
//  APICaller.swift
//  Netflix
//
//  Created by Rohit Sharma on 12/12/22.
//

import Foundation
import UIKit


class Constants {
    static let API_Key = "b430b4d0163c23106730cf79358c8f41"
    static let BaseUrl = "https://api.themoviedb.org/3/"
}

class APICaller{
    
    static let shared = APICaller()
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.BaseUrl)movie/upcoming?api_key=\(Constants.API_Key)&language=en-US&page=1")  else {return}
      
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.BaseUrl)trending/movie/day?api_key=\(Constants.API_Key)")  else {return}
      
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.BaseUrl)trending/tv/day?api_key=\(Constants.API_Key)")  else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.BaseUrl)movie/top_rated?api_key=\(Constants.API_Key)&language=en-US&page=1")  else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title] , Error>)-> Void){
        guard let url = URL(string: "\(Constants.BaseUrl)movie/popular?api_key=\(Constants.API_Key)&language=en-US&page=1")  else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data ,_, error in
            guard let data = data , error == nil
                else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title],Error>) -> Void ){
        guard let url = URL(string: "\(Constants.BaseUrl)discover/movie?api_key=\(Constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")
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
                print(error)
            }
            
        }
        task.resume()
    }
    
    func getSearchQueryResults(with query : String , completion: @escaping (Result<[Title],Error>) -> Void ){
        
        guard  let queryRequest = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.BaseUrl)search/movie?api_key=\(Constants.API_Key)&query=\(queryRequest)")
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
                print(error)
            }
            
        }
        task.resume()
    }
}
