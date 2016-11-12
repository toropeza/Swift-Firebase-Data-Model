//
//  DataModel.swift
//  FirebaseTutorial
//
//  Created by Thomas Oropeza on 11/10/16.
//  Copyright © 2016 Thomas Oropeza. All rights reserved.
//

import Foundation
import Firebase

class FirebaseDataModel {
    var dataKey = "Data"
    
    
    var data = [String]()
    var firebaseReference: FIRDatabaseReference
    
    
    init() {
        FIRApp.configure()
        firebaseReference = FIRDatabase.database().reference()
        setObservers()
    }
    
    func setObservers(){
        //1
        firebaseReference.child("data/list").observe(FIRDataEventType.value, with: {
            (snapshot) in
            
            //2
            self.data = [String]()
            
            //3
            let children = snapshot.children
            while let child = children.nextObject() as? FIRDataSnapshot {
                self.data.append(child.value as! String)
            }
            
            //4
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        })
    }
    
    func addItem(item: String){
        data.append(item)
        firebaseReference.child("data/list").childByAutoId().setValue(item)
    }
    
    func removeItem(item: String){
        
        //1
        if let index = data.index(of: item){
            data.remove(at: index)
        }
        
        //2
        firebaseReference.child("data/list").observeSingleEvent(of: FIRDataEventType.value, with: {
            (snapshot) in
            //3
            let children = snapshot.children
            while let child = children.nextObject() as? FIRDataSnapshot {
                if item == child.value as! String {
                    //4
                    child.ref.removeValue()
                    
                    
                    //5
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
                    break
                }
            }
        }, withCancel: nil)
    }
    
}
