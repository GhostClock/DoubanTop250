//
//  managedObjectContext.swift
//  DoubanTop250
//
//  Created by GhostClock on 2017/11/9.
//  Copyright © 2017年 GhostClock. All rights reserved.
//

import UIKit
import CoreData

class CoreDataObject: NSObject {
    
    // MARK: - CoreDataObject的单例
    static let shendInstance = CoreDataObject()
    private override init() {}
    
    
    // MARK: - 被管理的数据上下文,初始化后必须持久化存储助理
    var managedObjectContext: NSManagedObjectContext = {
        let coordinator = NSPersistentStoreCoordinator()
        var managedObjectContex = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContex.persistentStoreCoordinator = coordinator
        
        return managedObjectContex
    }()
    
    // MARK: - 持久化助理
    // 初始化必须依赖NSManagedObjectModel，之后要指定持久化存储数据类型，默认是NSSQLLiteStoreType,即SQLite数据库,并指定存储路径为DDocuments目录,以及数据库名称
    var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator()
        
        //获取Documents目录路径
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let doc = docs[docs.count - 1] as NSURL
        let url = doc.appendingPathComponent("CoreData.sqlite")
        
        var failurReason = "创建或者加载应用出错"
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "初始化错误保存数据失败" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failurReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain:"ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved\(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    
    // MARK: - 被管理的数据模型
    //初始化必须依赖.momd文件路径,而.momd文件由.xcdatamodeld文件编译而来
    var managedObjectModel: NSManagedObjectModel = {
        print(Bundle.main) //CoreData
        let modelURL = Bundle.main.url(forResource: "CoreData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    // MARK: - 保存数据到持久层
    func saveContext() -> Void {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // MARK: - 增加数据
    func addData(dataModel: MovieModel) -> Void {
        // 生成一个模型类似model
        let contactIonfo = NSEntityDescription.insertNewObject(forEntityName: "DoubanTop", into: managedObjectContext) as!  DoubanTop
        
        //点语法赋值
        contactIonfo.alt = dataModel.alt as String
        contactIonfo.average = dataModel.rating["average"] as? String
        contactIonfo.casts = "casts is NSArray"
        contactIonfo.collect_count = dataModel.collect_count
        contactIonfo.directors = "directors is Array"
        contactIonfo.genres = "genres is Array"
        contactIonfo.id = dataModel.id as String
        contactIonfo.large = dataModel.images_url["large"] as? String
        contactIonfo.original_title = dataModel.original_title as String
        contactIonfo.subtype = dataModel.subtype as String
        contactIonfo.title = dataModel.title as String
        contactIonfo.year = dataModel.year as String
        
        //保存数据
        saveContext()
    }
    
    private func fetchRequest(tableName: String) -> NSFetchRequest<NSFetchRequestResult> {
        //返回一个查询对象
        let fetch = NSFetchRequest<NSFetchRequestResult>.init()
        
        //生成一个要查询的表的对象
        let entity = NSEntityDescription.entity(forEntityName: tableName, in: managedObjectContext)
        
        //查询对象属性
        fetch.entity = entity
        
        return fetch
    }
    
    // MARK: - 查询数据
    func queryData(table: String) -> Void {
        
        let fetch = self.fetchRequest(tableName: table)
        
        //判断查询对象是否为空 防止Crash
        if fetch.entity != nil {
            //查询结果
            do {
                let qwqwrr:[AnyObject]? =  try managedObjectContext.fetch(fetch)
                for info: NSManagedObject in qwqwrr as! [NSManagedObject] {
                    print(info)
                }
            } catch{
                //查询失败
                fatalError("查询失败：\(error)")
            }
        }else{
            //查询对象不存在
            print("查询失败: 查询不存在")
        }
    }
    
    // MARK: - 修改数据
    func changeData(table: String, key: String, value: String) -> Void {
        let fetch = self.fetchRequest(tableName: table)
        
        //判断查询对象是否为空 防止Crash
        if fetch.entity != nil {
            //查询结果
            do {
                let temp:[AnyObject] = try managedObjectContext.fetch(fetch)
                //1 没有对象时
                #if false
                    for info:NSManagedObject in temp as! [NSManagedObject] {
                        info.setValue(value, value(forKey: key))
                    }
                #else
                    //0有对象时
                    for info:DoubanTop in temp as! [DoubanTop] {
                        // TODO:----------- 这里需要重新编写
                        info.alt = value
                    }
                #endif
            } catch  {
                fatalError("修改失败:\(error)")
            }
        }else{
            //查询失败
            print("查询失败:查询不存在")
        }
    }
    
    // MARK: - 删除数据
    func deleteData(table: String, key: String, value: String) -> Void {
        let fetch = self.fetchRequest(tableName: table)
        
        //判断查询对象是否为空 防止Crash
        if fetch.entity != nil{
            //查询结果
            do {
                let temp:[AnyObject] = try managedObjectContext.fetch(fetch)
                for info:DoubanTop in temp as! [DoubanTop] {
                    if info.alt == value {
                        //删除对象
                        managedObjectContext.delete(info)
                    }
                }
            } catch  {
                //操作失败
                fatalError("删除失败:\(error)")
            }
        }else{
            //查询失败
            print("查询失败:查询不存在")
        }
        //删除成功后再次保存到本地
        saveContext()
    }
    
    
    
}
