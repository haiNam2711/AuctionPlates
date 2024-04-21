//
//  SignInViewController.swift
//  AuctionPlates
//
//  Created by Hai Nam on 21/4/24.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var roleSwitcher: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpShadowPhoneView()
        phoneNumberTF.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setUpShadowPhoneView() {
        // Áp dụng đổ bóng
        phoneView.layer.shadowColor = UIColor.black.cgColor
        phoneView.layer.shadowOpacity = 0.2
        phoneView.layer.shadowOffset = CGSize(width: 0, height: 4)
        phoneView.layer.shadowRadius = 20
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton) {
        print(roleSwitcher.selectedSegmentIndex)
    }
    
}

//MARK: - Textfield delegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        var threshHold = 9
        threshHold = text != "" && text[0] == "0" ? 10 : 9
        goButton.isEnabled = text.count == threshHold || text.count == threshHold+1 ? true : false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneView.borderColor = UIColor(named: K.Color.darkGreen)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        phoneView.borderColor = UIColor(red: 0.93, green: 0.94, blue: 0.96, alpha: 1)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
