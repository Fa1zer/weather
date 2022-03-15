//
//  InformationTableViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 19.02.2022.
//

import UIKit
import SnapKit

final class InformationTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var config: (row: Int, text: String)? {
        
        didSet {
            
            guard let config = config else { return }

            self.valueLabel.text = config.text
            
            if config.row == 0 {
                
                self.weatherImageView.image = UIImage(named: "Frame-6")
                self.textWeatherLabel.text = "По ощущениям"
                
                self.weatherImageView.snp.makeConstraints { make in
                    make.height.equalTo(26)
                }
                
            } else if config.row == 1 {
                
                self.weatherImageView.image = UIImage(named: "ветер")
                self.textWeatherLabel.text = "Ветер"
                
                self.weatherImageView.snp.makeConstraints { make in
                    make.height.equalTo(14)
                }
                
            } else if config.row == 2 {
                
                self.weatherImageView.image = UIImage(named: "Frame")
                self.textWeatherLabel.text = "Уф индекс"
                
                self.weatherImageView.snp.makeConstraints { make in
                    make.height.equalTo(27)
                }
                
            } else if config.row == 3 {
                
                self.weatherImageView.image = UIImage(named: "Frame-3")
                self.textWeatherLabel.text = "Дождь"
                
                self.weatherImageView.snp.makeConstraints { make in
                    make.height.equalTo(30)
                }
                
            } else if config.row == 4 {
                
                self.weatherImageView.image = UIImage(named: "Frame-4")
                self.textWeatherLabel.text = "Облачность"
                
                self.weatherImageView.snp.makeConstraints { make in
                    make.height.equalTo(17)
                }
                
            }
            
        }
        
    }
    
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let textWeatherLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupViews() {
        
        self.backgroundColor = .clear
        
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(textWeatherLabel)
        self.contentView.addSubview(valueLabel)
        
        weatherImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(24)
        }
        
        textWeatherLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(weatherImageView.snp.trailing).inset(-15)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
    }

}
