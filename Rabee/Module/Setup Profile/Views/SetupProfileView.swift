//
//  SetupProfileView.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 31/07/23.
//

import UIKit

enum Gender: String {
    case man = "man"
    case woman = "woman"
}

class SetupProfileView: UIView {
    
    // MARK: Variables
    var didSaveBtnTapped: ((_ name: String, _ gender: String) -> Void)?
    var selectedGender: Gender = .man {
        didSet {
            switch selectedGender {
            case .man:
                manButton.style = .primary
                womanButton.style = .outlined
                avatarImage.image = UIImage(named: "ManAvatar")
            case .woman:
                manButton.style = .outlined
                womanButton.style = .primary
                avatarImage.image = UIImage(named: "WomanAvatar")
            }
        }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    let avatarImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 220, height: 220))
        image.image = UIImage(named: "ManAvatar")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let greetMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.text = "Halo"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.textTitle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTFTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Nama kamu"
        label.textColor = UIColor.textBlack
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: TextFieldWithPadding = {
        let textField =  TextFieldWithPadding(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .textBlack
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.peach.cgColor
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.backgroundColor = .whiteColor
        textField.addTarget(self, action: #selector(SetupProfileView.textFieldDidChange(_:)),
                                  for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let genderTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Jenis Kelamin"
        label.textColor = UIColor.textBlack
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let manButton: SegmentedButtonStyle = {
        let button = SegmentedButtonStyle(.primary)
        button.setTitle("Pria", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 71, height: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(buttonManClicked), for: .touchUpInside)
        return button
    }()
    
    private let womanButton: SegmentedButtonStyle = {
        let button = SegmentedButtonStyle(.outlined)
        button.setTitle("Wanita", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 71, height: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(buttonWomanClicked), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: PrimaryButton = {
        let button = PrimaryButton()
        button.buttonStyle = .peach
        button.setTitle("Simpan", for: .normal)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Action
    @objc private func buttonManClicked() {
        selectedGender = .man
    }
    
    @objc private func buttonWomanClicked() {
        selectedGender = .woman
    }
    
    @objc private func saveAction() {
        if nameTextField.text != "" {
            didSaveBtnTapped?(nameTextField.text ?? "", selectedGender.rawValue)
        } else {
            print("Text field can't be empty")
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let name = nameTextField.text ?? ""

        if name == "" {
            greetMessageLabel.text = "Halo"
        } else {
            greetMessageLabel.text = "Halo, \(nameTextField.text ?? "")"
        }
       
    }
    
    // MARK: - UI Set Up
    private func setupUI() {
        
        self.backgroundColor = UIColor.whiteColor
        
        self.addSubview(avatarImage)
        self.addSubview(greetMessageLabel)
        self.addSubview(nameTFTitleLabel)
        self.addSubview(nameTextField)
        self.addSubview(genderTitleLabel)
        self.addSubview(manButton)
        self.addSubview(womanButton)
        self.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 37),
            avatarImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 220),
            avatarImage.heightAnchor.constraint(equalToConstant: 220),
            
            greetMessageLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 36),
            greetMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            greetMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nameTFTitleLabel.topAnchor.constraint(equalTo: greetMessageLabel.bottomAnchor, constant: 56),
            nameTFTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: nameTFTitleLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            genderTitleLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 18),
            genderTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            manButton.topAnchor.constraint(equalTo: genderTitleLabel.bottomAnchor, constant: 8),
            manButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            manButton.heightAnchor.constraint(equalToConstant: 32),
            
            womanButton.topAnchor.constraint(equalTo: genderTitleLabel.bottomAnchor, constant: 8),
            womanButton.leadingAnchor.constraint(equalTo: manButton.trailingAnchor, constant: 10),
            womanButton.heightAnchor.constraint(equalToConstant: 32),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 41),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -41),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -45),
            
        ])
    }
    
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 10,
        bottom: 0,
        right: 0
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
