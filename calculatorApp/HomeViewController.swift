//
//  ViewController.swift
//  calculatorApp
//
//  Created by Maxos on 4/6/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var genderSegmentControll: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var activityField: UITextField!
    
    private let pickerView = UIPickerView()
    let activities = ["None", "Low", "Medium", "High"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSegmentedControll()
        configureTextFileds()
        configureActivityField()
        
    }
    
    @IBAction func calculateDidtap(_ sender: Any) {
        let weight = Int(weightField.text ?? "") ?? 0
        let height = Int(heightField.text ?? "") ?? 0
        let age = Int(ageField.text ?? "") ?? 0
        
        let activityIndex = pickerView.selectedRow(inComponent: 0)
        let activity = activities[activityIndex]
        var activityValue = 0
        switch activity {
        case "None":
            activityValue = 0
        case "Low":
            activityValue = 50
        case "Medium":
            activityValue = 150
        case "High":
            activityValue = 250
        default: break
        }
        
        let selectedGender = genderSegmentControll.selectedSegmentIndex
        
        var result = ""
        switch selectedGender {
        case 0:
            let result = 10 * weight + 6.25 * height - 5 * age + 5 + activityValue
            print("Male resultt is \(result)")
        case 1:
            let result = 8 * weight + 5.25 * height - 5 * age + 5 - 161 + activityValue
            print("Female: \(result)")
        default:
            break
            
        }
    }
    
    @IBAction func genderControllDidChange(_ sender: Any) {
//        switch (sender as AnyObject).selectedSegmentIndex {
//        case 0:
//            break
//        case 1:
//            break
//        default:
//            break
//        }
        clear()
    }
    
    
    @IBAction func clearDidTap(_ sender: Any) {
        clear()
    }
    
    
    func configureSegmentedControll() {
        genderSegmentControll.removeAllSegments()
        genderSegmentControll.insertSegment(withTitle: "Male", at: 0, animated: false)
        genderSegmentControll.insertSegment(withTitle: "Female", at: 1, animated: false)
        genderSegmentControll.selectedSegmentIndex = 0
    }
    
    func clear() {
        let textField = [weightField, heightField, ageField]
        for field in textField {
            field?.text = ""
        }
        weightField.becomeFirstResponder()
        pickerView.selectRow(0, inComponent: 0, animated: false)
        selectActivityBy(row: 0)
    }
    
    func configureTextFileds() {
        let textField = [weightField, heightField, ageField]
        for field in textField {
            field?.keyboardType = .numberPad
            field?.delegate = self
        }
        
        
    }
    
    func configureActivityField() {
        pickerView.dataSource = self
        pickerView.delegate = self
        activityField.inputView = pickerView
        activityField.text = activities[0]
    }
    
    func selectActivityBy(row: Int) {
        activityField.text = activities[row]
    }
}



extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectActivityBy(row: row)
    }
}
