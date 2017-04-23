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

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var recordsCountLabel: UILabel!
    @IBOutlet weak var courseName: UILabel!
    
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
        let fetchRequestForStudents:NSFetchRequest<Student> = Student.fetchRequest()
        let fetchRequestForCourses:NSFetchRequest<Course> = Course.fetchRequest()
        
        do {
            let searchResultsForStudents = try FWCDatabaseController.getContext().fetch(fetchRequestForStudents)
            
            let searchResultsForCourses = try FWCDatabaseController.getContext().fetch(fetchRequestForCourses)
            
            let totalRecords = searchResultsForStudents.count
            recordsCountLabel.text = String(describing:totalRecords)
            
            for studentResult in searchResultsForStudents as [Student] {
                let infoFetched = "\(studentResult.firstName!) \(studentResult.lastName!) is \(studentResult.age) years old."
                displayLabel.text = infoFetched
            }
            
            for courseResult in searchResultsForCourses as [Course] {
                let infoFetched = "\(courseResult.courseName!)"
                courseName.text = infoFetched
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

