//
//  AddFoodScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/20.
//

import UIKit

class EditDetailScreen: MyViewController {
    
    private let titleBar = AppTitleBar()
    private let scrollView = UIScrollView()
    private var contentView: EditDetailUI!
    
    private var evaluate = Int()
    
    private let uploadItem = ["相機", "相簿"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setUploadAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in uploadItem {
            let action = UIAlertAction(title: item, style: .default) { [weak self] _ in
                guard let self = self else { return }
                if item == "相機" {
                    
                } else {
                    
                }
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UI
extension EditDetailScreen {
    func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        
        titleBar.setTitle = "美食詳情"
        titleBar.setBackButtonImage = .backCircle
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
                
        contentView = EditDetailUI(width: width, height: safeAreaHeight)
        contentView.setDelegate = self
        
        contentView.setStarButtonAction(0) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 0
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(1) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 1
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(2) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 2
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(3) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 3
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(4) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 4
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setUploadAction(0) { [weak self] in
            guard let self = self else { return }
            self.setUploadAction()
            self.contentView.setUploadPicture(0, picture: .arrowUp)
        }
        
        contentView.setUploadAction(1) { [weak self] in
            guard let self = self else { return }
            self.setUploadAction()
            self.contentView.setUploadPicture(1, picture: .arrowDown)
        }
        
        contentView.setNextButtonAction = { [weak self] in
            guard let self = self else { return }
            self.MyPrint(evaluate)
        }
                
        let appScreen = MyStack(arrangedSubviews: [titleBar, scrollView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            scrollView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension EditDetailScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let Characters = "0123456789"
        textField.autocapitalizationType = .allCharacters
        
        switch textField {
        case contentView.getTextField(.minPrice), contentView.getTextField(.maxPrice), contentView.getTextField(.phoneNumber):
            
            let allowedCharacters = CharacterSet(charactersIn: Characters)
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        default:
            return true
        }
    }
}
