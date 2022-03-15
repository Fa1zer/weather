//
//  SunsetSunriseTableViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 20.02.2022.
//

import UIKit
import SnapKit

final class SunsetSunriseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sunsetSunriseTime: SunsetSinrise? {
        
        didSet {
            
            guard let sunsetSunriseTime = sunsetSunriseTime else { return }

            self.sunTimeLabel.text = sunsetSunriseTime.sun
            self.moonTimeLabel.text = sunsetSunriseTime.moon
            self.leftSunriseTimeLabel.text = sunsetSunriseTime.sunriseTime
            self.rightSunriseTimeLabel.text = sunsetSunriseTime.sunsetTime
            self.leftSunsetTimeLabel.text = sunsetSunriseTime.sunsetTime
            self.rightSunsetTimeLabel.text = sunsetSunriseTime.sunriseTime
            
        }
        
    }
    
    private let sunAndMoonLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Солнце и луна"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let firstBigStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondBigStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstLeftStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstRightStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondLeftStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondRightStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let thirdLeftStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let thirdRightStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let sunImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Frame"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let moonImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "crescent-moon 1"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let sunTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let moonTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let leftSunriseTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Восход"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rightSunriseTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Восход"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let leftSunriseTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rightSunriseTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let leftSunsetTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Заход"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rightSunsetTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Заход"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let leftSunsetTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rightSunsetTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let separatorLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private func setupViews() {
        
        self.backgroundColor = .white
        
        self.contentView.addSubview(sunAndMoonLabel)
        self.contentView.addSubview(firstBigStackView)
        self.contentView.addSubview(secondBigStackView)
        self.contentView.addSubview(separatorLineView)
        
        self.firstBigStackView.addArrangedSubview(firstLeftStackView)
        self.firstBigStackView.addArrangedSubview(secondLeftStackView)
        self.firstBigStackView.addArrangedSubview(thirdLeftStackView)
        
        self.secondBigStackView.addArrangedSubview(firstRightStackView)
        self.secondBigStackView.addArrangedSubview(secondRightStackView)
        self.secondBigStackView.addArrangedSubview(thirdRightStackView)
        
        self.firstLeftStackView.addSubview(sunImageView)
        self.firstLeftStackView.addSubview(sunTimeLabel)
        
        self.secondLeftStackView.addSubview(leftSunriseTextLabel)
        self.secondLeftStackView.addSubview(leftSunriseTimeLabel)
        
        self.thirdLeftStackView.addSubview(leftSunsetTextLabel)
        self.thirdLeftStackView.addSubview(leftSunsetTimeLabel)
        
        self.firstRightStackView.addSubview(moonImageView)
        self.firstRightStackView.addSubview(moonTimeLabel)
        
        self.secondRightStackView.addSubview(rightSunriseTextLabel)
        self.secondRightStackView.addSubview(rightSunriseTimeLabel)
        
        self.thirdRightStackView.addSubview(rightSunsetTextLabel)
        self.thirdRightStackView.addSubview(rightSunsetTimeLabel)
        
        sunAndMoonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
        }
        
        firstBigStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(self.contentView.snp.centerX).inset(-0.5)
            make.top.equalTo(sunAndMoonLabel.snp.bottom).inset(-15)
        }
        
        secondBigStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalTo(self.contentView.snp.centerX).inset(-0.5)
            make.top.equalTo(sunAndMoonLabel.snp.bottom).inset(-15)
        }
        
        firstLeftStackView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        firstRightStackView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        secondLeftStackView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        secondRightStackView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        thirdLeftStackView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }

        thirdRightStackView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        sunImageView.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(19)
        }
        
        moonImageView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(19)
        }
        
        sunTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        moonTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        leftSunriseTextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(19)
        }
        
        rightSunriseTextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(19)
        }
        
        leftSunriseTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        rightSunriseTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        leftSunsetTextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
        
        rightSunsetTextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
        
        leftSunsetTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        rightSunsetTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        separatorLineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.top.bottom.equalTo(firstBigStackView)
        }
        
    }

}
