//
//  TwentyHoursCollectionReusableView.swift
//  Weather
//
//  Created by Artemiy Zuzin on 03.02.2022.
//

import UIKit
import SnapKit

final class TwentyHoursCollectionReusableView: UICollectionReusableView {
    
    var buttonAction: (() -> Void)?
    
    private let twentyFourHoursButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.text = "Подробнее не 24 часа"
        button.tintColor = .black
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
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
        
        self.addSubview(twentyFourHoursButton)
        
        twentyFourHoursButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
        }
        
        twentyFourHoursButton.titleLabel?.snp.makeConstraints({ make in
            make.trailing.equalTo(self.snp.trailing).inset(32)
        })
        
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
