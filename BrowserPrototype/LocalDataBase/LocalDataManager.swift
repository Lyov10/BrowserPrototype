//
//  LocalDataManager.swift
//  BrowserPrototype
//
//  Created by 4steps on 16.05.23.
//

import CoreData

final class LocalDataManager {
    let context = AppDelegate().persistentContainer.viewContext
    public static let sharedInstance = LocalDataManager()
    private init() {}
    
    
     func getUrls() -> [String?] {
        var history: [String?] = []
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        do {
            let historyEntities = try context.fetch(fetchRequest)
            // Iterate through each URLArrayEntity object and retrieve its URLs
            for urlEntity in historyEntities {
                if let urls = urlEntity.url {
                    for url in urls {
                        if let urlString = url as? URLEntity {
                            history.append(urlString.urlString)
                        }
                    }
                }
            }
        } catch let error {
            print("Error fetching URLArrayEntity objects: \(error.localizedDescription)")
        }
        return history
    }
    func saveUrl(_ url: URL) {
        let history =  History(context: context)
        let urlEntity = URLEntity(context: context)
        urlEntity.urlString = url.absoluteString
        history.addToUrl(urlEntity)
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
}
