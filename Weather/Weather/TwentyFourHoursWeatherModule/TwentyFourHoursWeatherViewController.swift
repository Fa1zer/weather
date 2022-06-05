//
//  TwentyFourHoursWeatherViewController.swift
//  Weather
//
//  Created by Artemiy Zuzin on 05.02.2022.
//

import UIKit
import SnapKit

final class TwentyFourHoursWeatherViewController: UIViewController {
    
    init(viewModel: TwentyFourHoursWeatherViewModel, index: Int) {
        
        self.viewModel = viewModel
        self.index = index
        
        super.init(nibName: nil, bundle: nil)
        
        self.locationLabel.text = self.viewModel.getCityNames(index: index)
        
        self.viewModel.callBack = { [ weak self ] in
            
            self?.locationLabel.text = self?.viewModel.getCityNames(index: index)
            
            self?.tableView.reloadData()
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let index: Int
    private let viewModel: TwentyFourHoursWeatherViewModel
    
    private let cellId = "weatherOneHour"
    
    private let popLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Прогноз на 24 часа"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Moscow, Russia"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TwentyFourHoursWeatherTableViewCell.self,
                                forCellReuseIdentifier: cellId)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setupView()
        
    }
    
    private func setupView() {
        
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .done,
            target: self,
            action: #selector(leftButtoDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.view.addSubview(popLabel)
        self.view.addSubview(locationLabel)
        self.view.addSubview(tableView)
        
        popLabel.snp.makeConstraints { make in
            guard let navigationController = self.navigationController else { return }
            
            make.centerY.equalTo(navigationController.navigationBar)
            make.leading.equalTo(navigationController.navigationBar).inset(52)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(popLabel)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(locationLabel.snp.bottom).inset(-15)
            make.bottom.equalToSuperview()
        }
        
    }
    
    @objc func leftButtoDidTap() {
        self.viewModel.popToHomepageController()
    }
    
}

extension TwentyFourHoursWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TwentyFourHoursWeatherTableViewCell else { return UITableViewCell() }
        
        cell.isMetric = self.viewModel.isMetric()
        cell.weather = viewModel.getTwentyFourHoursWeather(index: self.index)[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.viewModel.getTwentyFourHoursWeather(index: self.index).count > 24 { return 24 }
        
        return self.viewModel.getTwentyFourHoursWeather(index: self.index).count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
