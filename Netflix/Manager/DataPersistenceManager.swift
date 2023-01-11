//
//  DataPersistenceManager.swift
//  Netflix
//
//  Created by Rohit Sharma on 31/12/22.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager{
    
    static let shared = DataPersistenceManager()
    
    func saveDownloadTitleMovie(_ model : Title , completion : @escaping (Result<Void,Error>) -> Void) {
       
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
          let context = appDelegate.persistentContainer.viewContext
                
         let item = TitleModel(context: context)
        
        item.id = Int64(model.id)
        item.title = model.title
        item.overview = model.overview
        item.original_title = model.original_title
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        do{
            try context.save()
            completion(.success(()))
        }
        catch{
            completion(.failure(error))
        }
    }
    
    func fetchTitleModelList(completion : @escaping(Result<[TitleModel],Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<TitleModel>
        
        request = TitleModel.fetchRequest()
        
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(error))
        }
    }
    
    func deleteDownloadTitleMovie(_ model : TitleModel , completion : @escaping (Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        }
        catch{
            completion(.failure(error))
        }
    }
    
}
