//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    var entry: Entry?
    {
        didSet {
            updateViews()
        }
    }
    
    var entryController: EntryController?
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let bodyText = bodyTextView.text else { return }
        
        var mood: String!
        
        switch moodSegmentedControl.selectedSegmentIndex {
        case 0:
            mood = Mood.sad.rawValue
        case 1:
            mood = Mood.okay.rawValue
        case 2:
            mood = Mood.happy.rawValue
        default:
            break
        }
        
        if let entry = entry {
            entryController?.update(entry: entry, title: title, bodyText: bodyText, mood: mood)
        } else {
            entryController?.createEntry(with: title, bodyText: bodyText, mood: mood)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard self.isViewLoaded else { return }
        
        guard let entry = entry else {
                title = "Create Entry"
                return
        }
        
        guard let title = entry.title,
              let bodyText = entry.bodyText else {
            return
        }
        self.titleTextField?.text = title
        self.bodyTextView?.text = bodyText
        
        var segmentIndex = 0
        
        switch entry.mood {
        case Mood.sad.rawValue:
            segmentIndex = 0
        case Mood.okay.rawValue:
            segmentIndex = 1
        case Mood.happy.rawValue:
            segmentIndex = 2
        default:
            break
        }
        
        self.moodSegmentedControl?.selectedSegmentIndex = segmentIndex
    }
}
