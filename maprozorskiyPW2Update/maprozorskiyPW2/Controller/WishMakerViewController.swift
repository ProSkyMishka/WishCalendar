//
//  WishMakerViewController.swift
//  maprozorskiyPW2
//
//  Created by Михаил Прозорский on 23.09.2023.
//

import UIKit

class WishMakerViewController: UIViewController {
    private let titleView = UILabel()
    private let actionStack = UIStackView()
    private let buttonHide = UIButton()
    private let buttonShow = UIButton()
    private let stack = UIStackView()
    private let descrip = UILabel()
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        view.addSubview(stack)
        view.addSubview(addWishButton)
        configureTitle()
        configureDescription()
        configureSliders()
        configureStackButtons()
        configureButtonHide()
        buttonShow.isHidden = true
        configureButtonShow()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.textColor = .white
        if (view.backgroundColor == titleView.backgroundColor) {
            titleView.backgroundColor = .red
        }
        titleView.text = "WishMaker"
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        view.addSubview(titleView)
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    private func configureDescription() {
        descrip.translatesAutoresizingMaskIntoConstraints = false
        descrip.textColor = .black
        descrip.text = "This app makes your wishes"
        descrip.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        view.addSubview(descrip)
        descrip.pinCenterX(to: view.centerXAnchor)
        descrip.pinTop(to: titleView.bottomAnchor, Constants.descriptionTop)
    }
    
    private func configureAddWishButton() {
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.black, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTextSize, weight: .bold)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureScheduleWishButton() {
        scheduleWishButton.setHeight(Constants.buttonHeight)
        scheduleWishButton.backgroundColor = .white
        scheduleWishButton.setTitleColor(.black, for: .normal)
        scheduleWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTextSize, weight: .bold)
        scheduleWishButton.setTitle(Constants.buttonTextSchedule, for: .normal)
        scheduleWishButton.layer.cornerRadius = Constants.buttonRadius
        scheduleWishButton.addTarget(self, action: #selector(buttonScheduleWishWasPressed), for: .touchUpInside)
    }
    
    private func configureStackButtons() {
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = Constants.spacing
        
        for button in [addWishButton, scheduleWishButton] {
        actionStack.addArrangedSubview(button)
        }
        
        configureAddWishButton()
        configureScheduleWishButton()
        
        actionStack.pinBottom(to: view, Constants.stackBottom)
        actionStack.pinHorizontal(to: view, Constants.stackLeading)
    }
    
    private func configureButtonHide() {
        buttonHide.translatesAutoresizingMaskIntoConstraints = false
        buttonHide.layer.cornerRadius = Constants.buttonHSRadius
        buttonHide.setTitle("Hide sliders", for: .normal)
        buttonHide.setTitleColor(.white, for: .normal)
        buttonHide.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonHSTextSize)
        buttonHide.backgroundColor = .black
        view.addSubview(buttonHide)
        buttonHide.setWidth(Constants.buttonHSWidth)
        buttonHide.pinCenterX(to: view.centerXAnchor)
        buttonHide.pinTop(to: descrip.bottomAnchor, Constants.buttonHSTop)
        buttonHide.addTarget(self, action: #selector(buttonHideWasPressed), for: .touchUpInside)
    }
    
    private func configureButtonShow() {
        buttonShow.translatesAutoresizingMaskIntoConstraints = false
        buttonShow.layer.cornerRadius = Constants.buttonHSRadius
        buttonShow.setTitle("Show sliders", for: .normal)
        buttonShow.setTitleColor(.white, for: .normal)
        buttonShow.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonHSTextSize)
        buttonShow.backgroundColor = .black
        view.addSubview(buttonShow)
        buttonShow.setWidth(Constants.buttonHSWidth)
        buttonShow.pinCenterX(to: view.centerXAnchor)
        buttonShow.pinTop(to: descrip.bottomAnchor, Constants.buttonHSTop)
        buttonShow.addTarget(self, action: #selector(buttonShowWasPressed), for: .touchUpInside)
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        
        stack.pinCenterX(to: view.centerXAnchor)
        stack.pinLeft(to: view.leadingAnchor, Constants.stackLeading)
        stack.pinBottom(to: addWishButton.topAnchor, Constants.buttonBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: value,
                green: ((self?.view.backgroundColor?.cgColor.components![1])!),
                blue: ((self?.view.backgroundColor?.cgColor.components![2])!),
                alpha: 1)
            Vars.backColor = (self?.view.backgroundColor)!
            self?.addWishButton.backgroundColor = MakeColor.makeColor()
            self?.scheduleWishButton.backgroundColor = MakeColor.makeColor()
            self?.addWishButton.setTitleColor(Vars.backColor, for: .normal)
            self?.scheduleWishButton.setTitleColor(Vars.backColor, for: .normal)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: ((self?.view.backgroundColor?.cgColor.components![0])!),
                green: ((self?.view.backgroundColor?.cgColor.components![1])!),
                blue: value,
                alpha: 1)
            Vars.backColor = (self?.view.backgroundColor)!
            self?.addWishButton.backgroundColor = MakeColor.makeColor()
            self?.scheduleWishButton.backgroundColor = MakeColor.makeColor()
            self?.addWishButton.setTitleColor(Vars.backColor, for: .normal)
            self?.scheduleWishButton.setTitleColor(Vars.backColor, for: .normal)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: ((self?.view.backgroundColor?.cgColor.components![0])!),
                green: value,
                blue: ((self?.view.backgroundColor?.cgColor.components![2])!),
                alpha: 1)
            Vars.backColor = (self?.view.backgroundColor)!
            self?.addWishButton.backgroundColor = MakeColor.makeColor()
            self?.scheduleWishButton.backgroundColor = MakeColor.makeColor()
            self?.addWishButton.setTitleColor(Vars.backColor, for: .normal)
            self?.scheduleWishButton.setTitleColor(Vars.backColor, for: .normal)
        }
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    @objc
    func buttonHideWasPressed() {
        stack.isHidden = true
        buttonHide.isHidden = true
        buttonShow.isHidden = false
    }
    
    @objc
    func buttonShowWasPressed() {
        stack.isHidden = false
        buttonShow.isHidden = true
        buttonHide.isHidden = false
    }
    
    @objc
    private func buttonScheduleWishWasPressed() {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
