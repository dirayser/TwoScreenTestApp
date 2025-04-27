//
//  StorageService.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 28.04.2025.
//

import CoreData
import UIKit

protocol StorageServiceProtocol {
  func saveCharacters(_ characters: [Character])
  func fetchCharacters() -> [Character]
}

class StorageService: StorageServiceProtocol {
  
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func saveCharacters(_ characters: [Character]) {
    clearCharacters(ids: characters.map { Int32($0.id) })
    
    for character in characters {
      let entity = CharacterEntity(context: context)
      entity.id = Int32(character.id)
      entity.name = character.name
      entity.status = character.status
      entity.species = character.species
      entity.type = character.type
      entity.gender = character.gender
      entity.originName = character.origin.name
      entity.locationName = character.location.name
      entity.imageURL = character.image
    }
    
    try? context.save()
  }
  
  func fetchCharacters() -> [Character] {
    let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
    guard let result = try? context.fetch(request) else { return [] }
    
    return result.map { entity in
      Character(id: Int(entity.id),
                name: entity.name ?? "",
                status: entity.status ?? "",
                species: entity.species ?? "",
                type: entity.type ?? "",
                gender: entity.gender ?? "",
                origin: .init(name: entity.originName ?? ""),
                location:  .init(name: entity.locationName ?? ""),
                image: entity.imageURL ?? "")
    }
  }
  
  private func clearCharacters(ids: [Int32]) {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CharacterEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id IN %@", ids)
    
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    deleteRequest.resultType = .resultTypeObjectIDs
    
    do {
      let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
      if let objectIDs = result?.result as? [NSManagedObjectID] {
        let changes = [NSDeletedObjectsKey: objectIDs]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
      }
    } catch {
      print("Failed to batch delete characters:", error.localizedDescription)
    }
  }
}
