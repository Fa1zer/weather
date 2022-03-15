//
//  TwentyFiveDaysWeatherTableViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 15.02.2022.
//

import UIKit
import SnapKit

class TwentyFiveDaysWeatherTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(InformationTableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isMetric: Bool?
    
    var weather: TwentyFiveDaysWeather? {
        
        didSet {
            
            guard let weather = weather else { return }
            
            self.timeLabel.text = weather.isNight ? "Ночь" : "День"
            self.isRainImageView.image = UIImage(named: weather.isRain ? "Frame-3" : "Frame")
            self.realGradusLabel.text = "\(weather.realGraduation)°"
            self.isRainLabel.text = weather.isRain ? "Ливни" : "Солнце"
            
            self.tableView.reloadData()
            
        }
        
    }
    
    private let cellId = "informationCell"
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let isRainImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let realGradusLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let isRainLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private func setupViews() {
        
        self.backgroundColor = .clear
        
        self.addSubview(containerView)
        
        self.containerView.addSubview(timeLabel)
        self.containerView.addSubview(stackView)
        self.containerView.addSubview(isRainLabel)
        self.containerView.addSubview(tableView)
        
        self.stackView.addArrangedSubview(isRainImageView)
        self.stackView.addArrangedSubview(realGradusLabel)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(15)
        }
        
        isRainImageView.snp.makeConstraints { make in
            make.width.equalTo(isRainImageView.snp.height)
        }
        
        isRainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).inset(-10)
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(245)
            make.top.equalTo(isRainLabel.snp.bottom).inset(-15)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }

}

extension TwentyFiveDaysWeatherTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? InformationTableViewCell else { return UITableViewCell() }
        
        guard let weather = weather else { return cell }
        
        if indexPath.row == 0 {
            cell.config = (indexPath.row, "\(weather.graduation)°")
        } else if indexPath.row == 1 {
            cell.config = (indexPath.row, "\(weather.windSpeed)\((self.isMetric ?? false) ? "m/s" : "mi/h")")
        } else if indexPath.row == 2 {
            cell.config = (indexPath.row, "\(weather.index)")
        } else if indexPath.row == 3 {
            cell.config = (indexPath.row, "\(weather.rainyProcent)%")
        } else if indexPath.row == 4 {
            cell.config = (indexPath.row, "\(weather.cloudyProcent)%")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
}
