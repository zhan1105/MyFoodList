//
//  MyDatePickerController.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/8.
//

import UIKit

class MyDatePicker: UIView {
    
    private let confirmButton = MyButton(text: .localizedString(for: .shared(.Confirm)))
    private let spacerButton = MyButton()
    private let datePicker = UIDatePicker()
    
    weak var delegate: MyDatePickerDelegate?
    
    var selectedDate: Date? {
        get {
            return datePicker.date
        }
        set {
            datePicker.date = newValue ?? Date()
        }
    }
    
    var datePickerMode: UIDatePicker.Mode {
        get {
            return datePicker.datePickerMode
        }
        set {
            datePicker.datePickerMode = newValue
        }
    }
    
    var preferredDatePickerStyle: UIDatePickerStyle {
        get {
            return datePicker.preferredDatePickerStyle
        }
        set {
            datePicker.preferredDatePickerStyle = newValue
        }
    }
    
    var startTime: Date? {
        get {
            return datePicker.minimumDate
        }
        set {
            datePicker.minimumDate = newValue
        }
    }
    
    var endTime: Date? {
        get {
            return datePicker.maximumDate
        }
        set {
            datePicker.maximumDate = newValue
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.charcoalBlack.withAlphaComponent(0.6)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        spacerButton.backgroundColor = .clear
        spacerButton.buttonAction = { [weak self] in
            self?.dismissDatePicker()
            if let selectedDate = self?.datePicker.date {
                self?.delegate?.datePickerDidSelect(date: selectedDate)
            }
        }
        
        confirmButton.backgroundColor = .clear
        confirmButton.setTitleColor(.oceanBlue, for: .normal)
        confirmButton.titleLabel?.font = .callout
        confirmButton.contentHorizontalAlignment = .trailing

        confirmButton.buttonAction = { [weak self] in
            self?.dismissDatePicker()
            if let selectedDate = self?.datePicker.date {
                self?.delegate?.datePickerDidSelect(date: selectedDate)
            }
        }
        
        let leftSpacer = MySpacer()
        let rightSpacer = MySpacer()
        let toolBar = MyStack(arrangedSubviews: [leftSpacer, confirmButton, rightSpacer])
        toolBar.axis = .horizontal
        toolBar.backgroundColor = .pureWhite
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        leftSpacer.widthAnchor.constraint(equalTo: toolBar.widthAnchor, multiplier: 0.725).isActive = true
        confirmButton.widthAnchor.constraint(equalTo: toolBar.widthAnchor, multiplier: 0.25).isActive = true
        rightSpacer.widthAnchor.constraint(equalTo: toolBar.widthAnchor, multiplier: 0.025).isActive = true
        
        datePicker.date = Date()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .pureWhite
        
        let selectLanguage = LanguageManager.shared.currentLanguage
        switch selectLanguage {
        case .chinese:
            datePicker.locale = Locale(identifier: "zh_TW")
        case .english:
            datePicker.locale = Locale(identifier: "en_PH")
        case .vietnamese:
            datePicker.locale = Locale(identifier: "vi_VN")
        case .indonesian:
            datePicker.locale = Locale(identifier: "id_ID")
            
        //TODO: 泰國語系，第一版關閉
//        case .thai:
//            datePicker.locale = Locale(identifier: "th_TH")
        }
        
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let appScreen = MyStack(arrangedSubviews: [spacerButton, toolBar, datePicker])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(appScreen)
        
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            spacerButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.7),
            toolBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.05),
            datePicker.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.25),
        ])
    }
    
    // MARK: - Open & Close Methods
    func showDatePicker(_ parentView: UIView, animated: Bool = true) {
        self.frame = parentView.bounds
        parentView.addSubview(self)
        
        if animated {
            self.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.alpha = 1
            }
        }
    }
    
    func dismissDatePicker(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
            }
        } else {
            self.removeFromSuperview()
        }
    }
}
