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
    }
    
    @IBAction func clearDidTap(_ sender: Any) {
    }
    
    
    func configureSegmentedControll() {
        genderSegmentControll.removeAllSegments()
        genderSegmentControll.insertSegment(withTitle: "Male", at: 0, animated: false)
        genderSegmentControll.insertSegment(withTitle: "Female", at: 1, animated: false)
        genderSegmentControll.selectedSegmentIndex = 0
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
