//
//  OneHourCollectionViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 03.02.2022.
//

import UIKit
import SnapKit

final class OneHourCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var weather: OneHourWeather? {
        
        didSet {
            
            guard let weather = weather else {
                return
            }
            
            self.timeLabel.text = weather.time
            self.graduationLabel.text = "\(weather.graduation)°"
            self.weatherImageView.image = UIImage(named: weather.weather)
            
        }
        
    }
    
    var isBlueBackground = false {
        
        didSet {
            
            if self.isBlueBackground {
                
                self.timeLabel.textColor = .white
                self.graduationLabel.textColor = .white
                self.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            
            } else {
                
                self.backgroundColor = .white
                self.graduationLabel.textColor = .black
                self.timeLabel.textColor = UIColor(red: 0.613, green: 0.592, blue: 0.592, alpha: 1)
                
            }
            
        }
        
    }
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.613, green: 0.592, blue: 0.592, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let graduationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupViews() {
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 22
        
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(graduationLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.leading.equalToSuperview().inset(5)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.height.width.equalTo(weatherImageView.snp.width)
        }
        
    }
    
}
