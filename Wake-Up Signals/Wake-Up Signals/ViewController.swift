//
//  ViewController.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 9/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePhoto() {
        print(345)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    //to know what image has been picked by the user
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            photoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            photoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        photoButton.layer.cornerRadius = photoButton.frame.width/2
        photoButton.layer.masksToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    let emailTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Email"
        txtField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txtField.borderStyle = .roundedRect
        txtField.font = UIFont.systemFont(ofSize: 14)
        
        txtField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return txtField
    }()
    
    @objc func handleTextInputChange(){
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && nameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 5
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
     
    }
    
    let nameTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Name"
        txtField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txtField.borderStyle = .roundedRect
        txtField.font = UIFont.systemFont(ofSize: 14)
        txtField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return txtField
    }()
    
    let passwordTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Password"
        txtField.isSecureTextEntry = true
        txtField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txtField.borderStyle = .roundedRect
        txtField.font = UIFont.systemFont(ofSize: 14)
        txtField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return txtField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(hanldeSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc func hanldeSignUp() {
        print(123)
        
        guard let email = emailTextField.text, email.count > 0  else { return }
        guard let username = nameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 6 else { return }
        
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
            if let err = error {
                print("Failed to create user: ", err)
                return
            }
            print("Successfully created user: ", user?.uid ?? "")
            //save user data to firebase database.
            //unwrap user uid
            
            guard let image = self.photoButton.imageView?.image else { return}
            guard let uploaddata =  UIImage.jpegData(compressionQuality: image,0.3) else {return}
            //crate universale filename
            filename = NSUIID().u
            
            
            
            guard let uid = user?.uid else { return }
            let usernameValues = ["username": username]
            
            let values = [uid:usernameValues]
            
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err,ref)  in
                if let err = err {
                    print("Failed to save user info into DB:", err)
                    return
                }
                print("Successfully saved user info do DB.")
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoButton) //still not visible
        photoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
//        photoButton.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
//        photoButton.center = view.center
//        photoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
//        photoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        photoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        setupInputFields()
        
    }

    fileprivate func setupInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, nameTextField,passwordTextField,signUpButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
//                //stackView.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 20),
//                stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
//                stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
                stackView.heightAnchor.constraint(equalToConstant: 200)
                ])
        stackView.anchor(top: photoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0 , height: 200 )
    }
}
// ? - mean optional parameter
extension UIView {
    @objcfunc anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            //same as "top!" for unwrapped, however in this case the if is exception protection.
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}


