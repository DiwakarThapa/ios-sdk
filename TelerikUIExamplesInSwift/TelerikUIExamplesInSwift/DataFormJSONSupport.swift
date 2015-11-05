//
//  DataFormJSONSupport.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class DataFormJSONSupport: UIViewController, TKDataFormDelegate {

    let dataForm = TKDataForm()
    var dataSource : TKDataFormEntityDataSource?
    var alert : TKAlert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataForm.frame = self.view.bounds
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        dataForm.allowScroll = false
        dataForm.delegate = self
        self.view.addSubview(dataForm)
        
        dataSource = TKDataFormEntityDataSource(dataFromJSONResource: "user", ofType: "json", rootItemKeyPath: nil)
        
        dataSource!["name"].index = 0
        dataSource!["age"].index = 1
        
        dataSource!["gender"].valuesProvider = ["Male", "Female"]
        dataSource!["gender"].editorClass = TKDataFormSegmentedEditor.self
        dataSource!["gender"].index = 2
        
        dataSource!["email"].index = 3
        dataSource!["email"].editorClass = TKDataFormEmailEditor.self
        
        dataForm.dataSource = dataSource
        dataForm.commitMode = TKDataFormCommitMode.Manual
        
        let save = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Done, target: self, action: "commitDataForm")
        self.navigationItem.rightBarButtonItem = save
        
    }
    
    func commitDataForm () {
        dataForm.commit()
        alert = TKAlert()
        alert!.title = "Saved"
        alert!.message = dataSource!.writeJSONToString()
        alert!.addActionWithTitle("OK") { (TKAlert, TKAlertAction) -> Bool in
            return true
        }
        
        alert!.show(true);
    }
    
    // MARK: TKDataFormDelegate
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        if property.name == "age" {
            let labelDef = editor.gridLayout.definitionForView((editor as! TKDataFormStepperEditor).valueLabel)
            labelDef.contentOffset = UIOffsetMake(-25, 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
