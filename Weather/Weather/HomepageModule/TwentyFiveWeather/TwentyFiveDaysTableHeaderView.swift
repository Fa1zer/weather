//
//  TwentyFourDaysTableHeaderView.swift
//  Weather
//
//  Created by Artemiy Zuzin on 04.02.2022.
//

import UIKit
import SnapKit

final class TwentyFiveDaysTableHeaderView: UIView {
    
    var buttonAction: (() -> Void)?
    
    private let everyDayForecastLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Ежедневный прогноз"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let twentyFiveDaysButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.text = "25 дней"
        button.titleLabel?.textAlignment = .right
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
        
        self.backgroundColor = .clear
        
        self.addSubview(everyDayForecastLabel)
        self.addSubview(twentyFiveDaysButton)
        
        everyDayForecastLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        twentyFiveDaysButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
    }
    
    @objc private func didTapButton() {
        self.buttonAction?()
    }
    
}
