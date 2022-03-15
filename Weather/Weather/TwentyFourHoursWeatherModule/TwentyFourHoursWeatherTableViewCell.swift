//
//  TwentyFourHoursWeatherTableViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 12.02.2022.
//

import UIKit
import SnapKit

final class TwentyFourHoursWeatherTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isMetric: Bool?
    
    var weather: TwentyFourHoursWeather? {
        
        didSet {
            
            guard let weather = weather else {
                return
            }
            
            self.dateLabel.text = weather.date
            self.timeLabel.text = weather.time
            self.graduationLabel.text = "\(weather.graduation)°"
            self.cloudyLabel.text = weather.cloudy
            self.windSpeedLabel.text = "\(weather.windSpeed)\((self.isMetric ?? false) ? "m/s" : "mi/h")"
            self.hummidityProcentLabel.text = "\(weather.hummidityProcent)%"
            self.cloudyProcentLabel.text = "\(weather.cloudyProcent)%"
            
            if weather.isNight {
                
                self.isNightImageView.image = UIImage(named: "crescent-moon 1")
                
            } else {
                
                self.isNightImageView.image = UIImage(named: "Frame")
                
            }
                        
        }
        
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .clear
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let graduationLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bigStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let thirdStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let fourthStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let isNightImageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cloudyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ветер"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Ветер"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let hummidityImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Frame-2"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let hummidityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Атмосферные осадки"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let hummidityProcentLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let cloudImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Frame-4"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cloudLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Облачность"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let cloudyProcentLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupViews() {
        
        self.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(graduationLabel)
        self.contentView.addSubview(bigStackView)
        
        self.bigStackView.addArrangedSubview(firstStackView)
        self.bigStackView.addArrangedSubview(secondStackView)
        self.bigStackView.addArrangedSubview(thirdStackView)
        self.bigStackView.addArrangedSubview(fourthStackView)
        
        self.firstStackView.addSubview(isNightImageView)
        self.firstStackView.addSubview(cloudyLabel)
        
        self.secondStackView.addSubview(windImageView)
        self.secondStackView.addSubview(windLabel)
        self.secondStackView.addSubview(windSpeedLabel)
        
        self.thirdStackView.addSubview(hummidityImageView)
        self.thirdStackView.addSubview(hummidityLabel)
        self.thirdStackView.addSubview(hummidityProcentLabel)
        
        self.fourthStackView.addSubview(cloudImageView)
        self.fourthStackView.addSubview(cloudLabel)
        self.fourthStackView.addSubview(cloudyProcentLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(15)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(dateLabel.snp.bottom).inset(-8)
            make.width.equalTo(65)
        }
        
        graduationLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel)
            make.top.equalTo(timeLabel.snp.bottom).inset(-8)
        }
        
        bigStackView.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.trailing).inset(-11)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(8)
            make.top.equalTo(timeLabel)
        }
        
        firstStackView.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        
        secondStackView.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        
        thirdStackView.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        
        fourthStackView.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        
        isNightImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(isNightImageView.snp.height)
        }
        
        cloudyLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(windLabel)
        }
        
        windImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(windImageView.snp.height).multipliedBy(1.5)
        }
        
        windLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(windImageView.snp.trailing).inset(-4)
        }
        
        windSpeedLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
        }
        
        hummidityImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(hummidityImageView.snp.height)
        }
        
        hummidityLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(windLabel)
        }
        
        hummidityProcentLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        cloudImageView.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview()
            make.width.equalTo(cloudImageView.snp.height).multipliedBy(1.5)
        }
        
        cloudLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(windLabel)
        }
        
        cloudyProcentLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
    }
    
}
