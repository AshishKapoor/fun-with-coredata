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

        // Insert
        let student:Student = NSEntityDescription.insertNewObject(forEntityName: kStudentClassName, into: FWCDatabaseController.getContext()) as! Student
        student.firstName   = "Ashish"
        student.lastName    = "Kapoor"
        student.age         = 25
        
        let course:Course = NSEntityDescription.insertNewObject(forEntityName: kCourseClassName, into: FWCDatabaseController.getContext()) as! Course
        course.courseName   = "MCSE-004"
        
        student.addToCourses(course)
        
        // Save
        FWCDatabaseController.saveContext()
        
        // Fetch
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
        
        // Delete
        FWCDatabaseController.getContext().delete(student)
        FWCDatabaseController.getContext().delete(course)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

