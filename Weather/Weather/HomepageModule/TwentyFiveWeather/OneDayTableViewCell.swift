//
//  OneDayTableViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 04.02.2022.
//

import UIKit
import SnapKit

final class OneDayTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var weather: OneDayWeather? {
        
        didSet {
            
            guard let weather = weather else { return }
            
            self.dateLabel.text = weather.date
            self.humidityProcentLabel.text = "\(weather.humidityProcent)%"
            self.humidityImageView.image = UIImage(named: weather.humidityImage)
            self.graduationsDifferenceLabel.text = weather.graduationsDifference
            self.informationLabel.text = weather.information
            
        }
        
    }
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "17/04"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let humidityImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let humidityProcentLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .blue
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Vector"))
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let graduationsDifferenceLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupViews() {
        
        self.backgroundColor = .clear
        
        self.addSubview(containerView)
        
        containerView.addSubview(dateLabel)
        containerView.addSubview(humidityImageView)
        containerView.addSubview(humidityProcentLabel)
        containerView.addSubview(arrowImageView)
        containerView.addSubview(graduationsDifferenceLabel)
        containerView.addSubview(informationLabel)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(6)
        }
        
        humidityImageView.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).inset(-3)
            make.height.equalTo(17)
            make.width.equalTo(15)
        }
        
        humidityProcentLabel.snp.makeConstraints { make in
            make.leading.equalTo(humidityImageView.snp.trailing).inset(-6)
            make.top.equalTo(dateLabel.snp.bottom).inset(-3)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(9.5)
            make.width.equalTo(6)
        }
        
        graduationsDifferenceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(arrowImageView.snp.leading).inset(-10)
            make.centerY.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints { make in
            make.leading.equalTo(humidityProcentLabel.snp.trailing).inset(-10)
            make.trailing.equalTo(graduationsDifferenceLabel.snp.leading).inset(-10)
            make.centerY.equalToSuperview()
        }
        
    }
    
}
