//
//  GenerateViewController.swift
//  RoomCaptureApp
//
//  Created by Maharjan on 20/04/2024.
//

import UIKit

class GenerateViewController: UIViewController{
    
    var viewModel = GenerateViewModel()
    
    lazy var wrapperView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter a prompt"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.text = "Enter a Style Prompt"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var generateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Generate", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(generateClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var promptTextField: UITextField = {
        let textfield = UITextField()
//        textfield.text = "Enter text"
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 16
        textfield.setLeftPaddingPoints(16)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var stylePromtField: UITextField = {
        let textfield = UITextField()
//        textfield.text = "Enter text"
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 16
        textfield.setLeftPaddingPoints(16)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    var completeGeneration: (() -> Void)?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(wrapperView)
        wrapperView.fillSuperview()
        wrapperView.addSubview(mainStackView)
        [titleLabel, promptTextField, subtitle, stylePromtField, generateButton].forEach {mainStackView.addArrangedSubview($0)}
        setupView()
        
    }
    
    @objc func generateClicked() {
//        if (promptTextField.text?.isEmpty == true && stylePromtField.text?.isEmpty == true) {
//            Banner.show(status: .error, title: "", message: "Please fill the prompt")
//        } else {
//            
//            
//        }
        viewModel.fetchObject(promt: promptTextField.text ?? "", style: stylePromtField.text ?? "")
    }
    
    func setupView() {
        mainStackView.anchor(top: wrapperView.topAnchor, leading: wrapperView.leadingAnchor, bottom: nil, trailing: wrapperView.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        promptTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stylePromtField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        generateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func bindViewModel() {
//        viewModel.shouldShowHUD = { [weak self] in
//            guard let self = self else { return }
////            HUD.show(self)
//        }
//        
//        viewModel.shouldDismissHUD = { [weak self] in
//            guard let self = self else { return }
////            HUD.hide(self) { _ in
//                //
////            }
//        }
    }
}
