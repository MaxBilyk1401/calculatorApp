//
//  ViewController.swift
//  calculatorApp
//
//  Created by Maxos on 4/6/23.
//

import UIKit

//class Activity {
//    let title: String
//    let value: Int
//
//    init(title: String, value: Int) {
//        self.title = title
//        self.value = value
//    }
//}
class HomeViewController: UIViewController {
    
    @IBOutlet weak var genderSegmentControll: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private let pickerView = UIPickerView()
    let activities: [Activity] = Activity.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Calculator"
        configureSegmentedControll()
        configureTextFileds()
        configureActivityField()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activitySugue" {
            if let activityController = segue.destination as? ActivitiesViewController {
                let activityIndex = self.pickerView.selectedRow(inComponent: 0)
                let activity = self.activities[activityIndex]
                activityController.activity = activity
                print("ActivityViewController prepare")
            }
        }
    }
    
    @IBAction func calculateDidtap(_ sender: Any) {
        let weight = Int(weightField.text ?? "") ?? 0
        let height = Int(heightField.text ?? "") ?? 0
        let age = Int(ageField.text ?? "") ?? 0
        
        if checkAllFields() {
            let activityIndex = pickerView.selectedRow(inComponent: 0)
            let activity = activities[activityIndex]
            let activityValue = activity.value
            
            guard let selectedGender = Gender(rawValue: genderSegmentControll.selectedSegmentIndex) else { return }

            switch selectedGender {
            case .male:
                let result = Double(10 * weight) + (6.25 * Double(height)) - Double(5 * age) + 5.0 + Double(activityValue)
                showAlertWith(title: String(result))
                
            case .female:
                let result = Double(8 * weight) + (5.25 * Double(height)) - Double(5 * age) + 5.0 - 161.0 + Double(activityValue)
                showAlertWith(title: String(result))
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
        alert.addAction(.init(title: "Detail info", style: .default) { _ in
            self.performSegue(withIdentifier: "activitySugue", sender: self)
        })
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
        selectActivityBy(row: 0)
    }
    
    func selectActivityBy(row: Int) {
        activityField.text = activities[row].title
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
        return activities[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectActivityBy(row: row)
    }
}
