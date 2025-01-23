//
//  PortfolioDataService.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 04/12/24.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntity: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_,error) in
           if let error = error
            {
               print("Error loading Core Data!\(error)")
           }
        }
    }
    
    
    private func getPortfololio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName:entityName)
        do {
            savedEntity = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching Portfolio Entities")
        }
            
    }
    private func addPortfololio(coin: CoinModel, amount: Double)
    {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
    }
    private func save() {
        do {
            try container.viewContext.save()
        }catch  let error {
            print("Error saving to core data \(error)")
        }
    }
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
    }
    
    private func applychanes(){
        
    }
}
