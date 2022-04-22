//
//  TwentyHoursCollectionReusableView.swift
//  Weather
//
//  Created by Artemiy Zuzin on 03.02.2022.
//

import UIKit
import SnapKit

class TwentyFourHoursHeaderView: UIView {
    
    var buttonAction: (() -> Void)?
    
    private let twentyFourHoursButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.text = "Подробнее не 24 часа"
        button.tintColor = .black
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16)
        
        guard let title = button.titleLabel?.text else { return button }
        
        button.setAttributedTitle(title.getUnderLineAttributedText(), for: .normal)
        
        return button
    }()
    
    
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupViews()
    }
    
    private func setupViews() {
        
        self.backgroundColor = .white
        
        self.twentyFourHoursButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        self.addSubview(twentyFourHoursButton)
        
        twentyFourHoursButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(20)
            make.trailing.equalToSuperview().inset(10)
        }
        
    }
    
    @objc private func didTapButton() {
        self.buttonAction?()
    }
    
}

extension String {
    
   func getUnderLineAttributedText() -> NSAttributedString {
       
       return NSMutableAttributedString(
        string: self,
        attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
       )
       
   }
    
}
