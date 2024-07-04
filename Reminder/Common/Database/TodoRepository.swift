//
//  TodoRepository.swift
//  Reminder
//
//  Created by 유철원 on 7/4/24.
//

import Foundation
import RealmSwift


final class TodoRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ data: Object) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            
        }
    }
    
    func fetchItem<T:Object>(object: T.Type, primaryKey: ObjectId) -> T? {
        return realm.object(ofType: object, forPrimaryKey: primaryKey)
    }
    
    func fetchAll<T: Object>(obejct: T.Type, sortKey: String, acending: Bool = true) -> [T] {
        let value = realm.objects(obejct).sorted(byKeyPath: sortKey, ascending: acending)
        return Array(value)
    }
    
    func fetchAllFiltered<T: Object>(obejct: T.Type, sortKey: String, acending: Bool = true, filter: (Query<T>) -> Query<Bool>) -> [T] {
        let value = realm.objects(obejct).where(filter).sorted(byKeyPath: sortKey, ascending: acending)
        return Array(value)
    }

    func deleteItem<T: Object>(_ data: T) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            
        }
    }
    
    func deleteItemWithResource(_ data: Object, fileName: String) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            
        }
    }
}

