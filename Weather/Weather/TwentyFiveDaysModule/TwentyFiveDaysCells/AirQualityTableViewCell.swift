//
//  AirQualityTableViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 21.02.2022.
//

import UIKit

final class AirQualityTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var airPoints: Int? {
        
        didSet {
            
            guard let airPoints = airPoints else { return }
            
            self.airPointsLabel.text = "\(airPoints)"
            
            if airPoints < 50 {
                
                self.evaluationLabel.text = "хорошо"
                self.evaluationLabel.backgroundColor = .systemGreen
                
            } else if airPoints > 49 && airPoints < 100 {
                
                self.evaluationLabel.text = "средене"
                self.evaluationLabel.backgroundColor = .systemYellow
                
            } else {
                
                self.evaluationLabel.text = "полохо"
                self.evaluationLabel.backgroundColor = .systemRed
                
            }
            
        }
        
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Качетво воздуха"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let airPointsLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let evaluationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bigTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Качество воздуха считается удовлетворительным и загрязнения воздуха в пределах нормы"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupViews() {
        
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(airPointsLabel)
        self.addSubview(evaluationLabel)
        self.addSubview(bigTextLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
        }
        
        airPointsLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
        }
        
        evaluationLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
            make.height.equalTo(26)
            make.centerY.equalTo(airPointsLabel)
            make.leading.equalTo(airPointsLabel.snp.trailing).inset(-15)
        }
        
        bigTextLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(airPointsLabel.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }

}
