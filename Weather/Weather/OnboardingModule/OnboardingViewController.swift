//
//  OnboardingViewController.swift
//  Weather
//
//  Created by Artemiy Zuzin on 01.02.2022.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: OnboardingViewModel
    
    private let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Frame 54"))
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.11

        label.attributedText = NSMutableAttributedString(
            string: "Разрешить приложению  Weather использовать данные о местоположении вашего устройства?",
            attributes: [NSAttributedString.Key.kern : 0.16,
                         NSAttributedString.Key.paragraphStyle : paragraphStyle]
        )
        
        label.font = UIFont(name: "ArialMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.21

        label.attributedText = NSMutableAttributedString(
            string: "Чтобы получить более точные прогнозы погоды во время движения или путешествия",
            attributes: [NSAttributedString.Key.kern : 0.14,
                         NSAttributedString.Key.paragraphStyle : paragraphStyle]
        )
        label.textColor = .white
        label.font = UIFont(name: "ArialMT", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 1.21

        label.attributedText = NSMutableAttributedString(
            string: "Вы можете изменить свой выбор в любое время из меню приложения",
            attributes: [NSAttributedString.Key.kern : 0.28,
                         NSAttributedString.Key.paragraphStyle : paragraphStyle]
        )
        label.textColor = .white
        label.font = UIFont(name: "ArialMT", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let disagreeButton: UIButton = {
        let button = UIButton()

        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .right
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(disagreeButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let agreeButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
        button.tintColor = .white
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(agreeButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        
        self.view.addSubview(image)
        self.view.addSubview(firstLabel)
        self.view.addSubview(secondLabel)
        self.view.addSubview(thirdLabel)
        self.view.addSubview(disagreeButton)
        self.view.addSubview(agreeButton)
        
        image.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(35)
            make.top.equalToSuperview().inset(62)
            make.height.equalTo(image.snp.width).inset(30)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(19)
            make.top.equalTo(image.snp.bottom).inset(-30)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(19)
            make.top.equalTo(firstLabel.snp.bottom).inset(-30)
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(19)
            make.top.equalTo(secondLabel.snp.bottom).inset(-10)
        }
        
        disagreeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(77)
        }
        
        agreeButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.trailing.leading.equalToSuperview().inset(17)
            make.bottom.equalTo(disagreeButton.snp.top).inset(-25)
        }
        
    }
    
    @objc private func agreeButtonDidTap() {
        self.viewModel.getLocation()
    }
    
    @objc private func disagreeButtonDidTap() {
        self.viewModel.pushMainMenu()
    }
    
}
