//
//  NewReminder.swift
//  ManageMyReminders
//
//  Created by Malek T. on 11/20/15.
//  Copyright © 2015 Medigarage Studios LTD. All rights reserved.
//

import UIKit
import EventKit

class addReminderController: UIViewController {
    
    
    // Properties
    var eventStore: EKEventStore!
    var datePicker: UIDatePicker!
    var datePicker2: UIDatePicker!
    
    var calendar: EKCalendar!
  
    @IBOutlet var scrollView : UIScrollView!
    
    @IBOutlet weak var nameEvent: UITextField!
    
    @IBOutlet var start: UITextField!
    @IBOutlet var ends: UITextField!
    
    var delegate: EventAddedDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: "startDate", forControlEvents: UIControlEvents.ValueChanged)
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        
        
        datePicker2 = UIDatePicker()
        datePicker2.addTarget(self, action: "endsDate", forControlEvents: UIControlEvents.ValueChanged)
        datePicker2.datePickerMode = UIDatePickerMode.DateAndTime
        
        
        start.inputView = datePicker
        ends.inputView = datePicker2
        nameEvent.becomeFirstResponder()
        
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(400, 800)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addReminderController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        navigationBar()
    }
    
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    func navigationBar(){
        self.navigationItem.title = "Set Your Reminder"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(addEventButtonTapped))
    }
    
    func back(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addEventButtonTapped(sender: UIBarButtonItem) {

        print("create Event")
        let store = EKEventStore()
        store.requestAccessToEntityType(.Event) {(granted, error) in
            if !granted { return }
            var event = EKEvent(eventStore: store)
            event.title = self.nameEvent.text!
            event.startDate = self.datePicker.date //today
            event.endDate = self.datePicker2.date //1 hour long meeting
            event.calendar = store.defaultCalendarForNewEvents
            do {
                try store.saveEvent(event, span: .ThisEvent, commit: true)
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Reminder Success"
                alertView.message = "Success Thanks"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            } catch {
                // Display error to user
            }
   

        }
        
    }
    
    func startDate(){
        self.start.text = self.datePicker.date.description
    }
    
    func endsDate(){
        self.ends.text = self.datePicker2.date.description
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
