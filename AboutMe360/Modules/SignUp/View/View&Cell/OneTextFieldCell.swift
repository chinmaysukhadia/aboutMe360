//
//  OneTextFieldCell.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 12/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit

class OneTextFieldCell: BaseTableViewCell,UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var inputTextField: ACFloatingTextfield!
    @IBOutlet weak var imageViewCheck: UIImageView!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    //MARK: - Variables
    var piker = UIPickerView()
    var pickerData = [String]()
    
    var textDidChanged: ((OneTextFieldCell, String?)-> Void)?
    var showPassword: ((OneTextFieldCell)-> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
       // inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textChange), for: .editingChanged)
    }
    
    @objc func textChange(_ textField: UITextField) {
        textDidChanged?(self, textField.text)
    }
    
    func initializationPiker(pikerdata : [String]) {
        inputTextField.inputView = piker
        piker.delegate = self
        piker.dataSource =  self
        self.pickerData = pikerdata
        piker.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.inputTextField.text = self.pickerData[row].trim()
        textDidChanged?(self, self.pickerData[row].trim())
    }
    
    @IBAction func showPasswordTapped(_ sender: Any) {
    showPassword?(self)
    }
    
}




