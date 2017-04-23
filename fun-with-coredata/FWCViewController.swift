//
//  FWCViewController.swift
//  fun-with-coredata
//
//  Created by Ashish Kapoor on 23/04/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import CoreData

class FWCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let student:Student = NSEntityDescription.insertNewObject(forEntityName: kStudentClassName, into: FWCDatabaseController.getContext()) as! Student
        
        student.firstName   = "Ashish"
        student.lastName    = "Kapoor"
        student.age         = 25
        
        FWCDatabaseController.saveContext()
        
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do {
            let searchResults = try FWCDatabaseController.getContext().fetch(fetchRequest)
            print(searchResults.count)
            
            for result in searchResults as [Student] {
                print("\(result.firstName!) \(result.lastName!) is \(result.age) years old.")
            }
        } catch {
            print("error: \(error)")
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
