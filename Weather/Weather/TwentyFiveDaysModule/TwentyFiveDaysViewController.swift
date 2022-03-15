//
//  TwentyFiveViewController.swift
//  Weather
//
//  Created by Artemiy Zuzin on 14.02.2022.
//

import UIKit
import SnapKit

final class TwentyFiveDaysViewController: UIViewController {
    
    init(viewModel: TwentyFiveDaysViewModel, index: Int, dateIndex: Int) {
                
        self.viewModel = viewModel
        self.index = index
        self.dateIndex = dateIndex
                
        super.init(nibName: nil, bundle: nil)
        
        self.locationLabel.text = self.viewModel.getCityNames(index: index)
                
        self.viewModel.callBack = { [ weak self ] in
            
            self?.locationLabel.text = self?.viewModel.getCityNames(index: index)
            
            self?.collectionView.reloadData()
            self?.tableView.reloadData()
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let index: Int
    private let viewModel: TwentyFiveDaysViewModel
    
    private let collectionViewCellId = "date"
    private let firstAndSecondTableViewCellId = "firtAndSecond"
    private let thirdTableViewCellId = "third"
    private let fourthTableViewCellId = "fourth"
    
    private var dateIndex: Int {
        
        didSet {
            
            self.tableView.reloadData()
            self.collectionView.selectItem(at: IndexPath(item: self.dateIndex, section: 0),
                                           animated: true,
                                           scrollPosition: .centeredHorizontally)
            
        }
        
    }
    
    private let popLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Прогноз на день"
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: 88, height: 36)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(DateCollectionViewCell.self,
                                forCellWithReuseIdentifier: collectionViewCellId)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TwentyFiveDaysWeatherTableViewCell.self,
                                forCellReuseIdentifier: firstAndSecondTableViewCellId)
        self.tableView.register(SunsetSunriseTableViewCell.self,
                                forCellReuseIdentifier: thirdTableViewCellId)
        self.tableView.register(AirQualityTableViewCell.self,
                                forCellReuseIdentifier: fourthTableViewCellId)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setupViews()
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .done,
            target: self,
            action: #selector(leftButtoDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.tableView.separatorColor = .clear
        
        self.view.addSubview(popLabel)
        self.view.addSubview(locationLabel)
        self.view.addSubview(collectionView)
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
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(locationLabel.snp.bottom).inset(-40)
            make.leading.trailing.equalToSuperview().inset(16)        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(collectionView.snp.bottom).inset(-20)
            make.bottom.equalToSuperview()
        }
        
    }
    
    @objc func leftButtoDidTap() {
        self.viewModel.popToHomepageController()
    }
 
}

extension TwentyFiveDaysViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.viewModel.getDatesCount(index: index)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId,
                                                            for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell() }
        
        cell.date = self.viewModel.getAllDates(index: self.index, secondIndex: indexPath.item)
        
        if indexPath.item == self.dateIndex {
            
            cell.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            cell.dateLabel.textColor = .white

        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let firstCell = self.collectionView.cellForItem(at: IndexPath(item: self.dateIndex, section: 0)) as? DateCollectionViewCell else { return }
        
        firstCell.backgroundColor = .white
        firstCell.dateLabel.textColor = .black
        
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell else { return }
        
        self.dateIndex = indexPath.item
        
        cell.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        cell.dateLabel.textColor = .white
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell else { return }
                
        cell.backgroundColor = .clear
        cell.dateLabel.textColor = .black
        
    }
    
}

extension TwentyFiveDaysViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 || indexPath.row == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: firstAndSecondTableViewCellId) as? TwentyFiveDaysWeatherTableViewCell else { return UITableViewCell() }
            
            if self.viewModel.allWeatherCount() - 1 < index { return UITableViewCell() }
            
            cell.isMetric = self.viewModel.isMetric()
            cell.weather = self.viewModel.getAllWeather(index: self.index,
                                                        secondIndex: self.dateIndex)[indexPath.row]
            
            return cell
            
        } else if indexPath.row == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: thirdTableViewCellId) as? SunsetSunriseTableViewCell else { return UITableViewCell() }
            
            cell.sunsetSunriseTime = self.viewModel.getSunsetSunrise(index: self.index,
                                                                     secondIndex: self.dateIndex)
            
            return cell
            
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: fourthTableViewCellId) as? AirQualityTableViewCell else { return UITableViewCell() }
        
        cell.airPoints = self.viewModel.getAirPoints(index: self.index, secondIndex: self.dateIndex)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
