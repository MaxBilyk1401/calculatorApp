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
    @IBOutlet weak var resultLabel: UILabel!
    
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
        
        if checkAllFields() {
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
                let result = Double(10 * weight) + (6.25 * Double(height)) - Double(5 * age) + 5.0 + Double(activityValue)
                showAlertWith(title: String(result))
                
            case 1:
                let result = Double(8 * weight) + (5.25 * Double(height)) - Double(5 * age) + 5.0 - 161.0 + Double(activityValue)
                showAlertWith(title: String(result))
            default:
                break
            }
        } else {
            print("Поля не мають відповідних значень")
        }
    }
        
    
    @IBAction func genderControllDidChange(_ sender: Any) {
        clear()
    }
    
    
    @IBAction func clearDidTap(_ sender: Any) {
        clear()
    }
    
    func showAlertWith(title: String) {
        let alert = UIAlertController(title: "Your result", message: title, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
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
    
    func checkAllFields() -> Bool {
        //Перевірка текстфілдів чи значення більше нуля.
        if let text1 = weightField.text, let number1 = Int(text1), number1 > 0,
           let text2 = heightField.text, let number2 = Int(text2), number2 > 0,
           let text3 = ageField.text, let number3 = Int(text3), number3 > 0 {
            return true
        }
      return false
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
