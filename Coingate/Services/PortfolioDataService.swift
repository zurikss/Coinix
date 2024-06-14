//
//  PortfolioDataService.swift
//  Coingate
//
//  Created by Victor on 09/11/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading coredata \(error)")
            }
            self.getPortfolio()
        }
        
    }
    
    // MARK: PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            addToCoreData(coin: coin, amount: amount)
        }
    }
    
//    func addProfile(profile: String) {
//        let entity = PortfolioEntity(context: container.viewContext)
//        entity.profile = profile
//        updateProfile(entity: entity, profile: profile)
//        saveToCoreData()
//    }
    
    // MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching porfolio entities \(error)")
        }
    }
    
    private func addToCoreData(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount

        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
//    private func updateProfile(entity: PortfolioEntity, profile: String) {
//        entity.profile = profile
//        saveToCoreData()
//    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func saveToCoreData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core data \(error)")
        }
    }
    
    private func applyChanges() {
        saveToCoreData()
        getPortfolio()
    }
    

}
