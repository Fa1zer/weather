//
//  HomepageViewController.swift
//  Weather
//
//  Created by Artemiy Zuzin on 02.02.2022.
//

import UIKit
import SnapKit

final class HomepageViewController: UIViewController {
    
    init(viewModel: HomepageViewModel) {
        
        self.viewModel = viewModel
                
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.callBack = { [ weak self ] in
            
            DispatchQueue.main.async {
                
                self?.getInformation()
                
            }
            
        }
        
        self.getInformation()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var lastCount = Int()
    
    private let viewModel: HomepageViewModel
    
    private let collectionViewCellId = "24hours"
    private let collectionViewHeaderId = "headerCollectionView"
    private let tableViewCellId = "25days"
        
    private let plusImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "plus"))
        
        view.tintColor = .black
        view.isHidden = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let pageConrol: UIPageControl = {
        let view = UIPageControl()
        
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .systemGray2
        view.addTarget(self, action: #selector(pageControllDidUse(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
        
    private let informationStackView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let elipseImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Ellipse 3"))
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let sunriseImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "daytime 1"))
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let sunsetImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "sunset 1"))
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let graduationsLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let graduationNowLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bigGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 5
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    
    private let thirdGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cloudyImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Group"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ветер"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let humidityImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Frame-2"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let twentyFourHoursHeaderView = TwentyFourHoursHeaderView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: 65, height: 130)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            OneHourCollectionViewCell.self,
            forCellWithReuseIdentifier: collectionViewCellId
        )
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(OneDayTableViewCell.self, forCellReuseIdentifier: tableViewCellId)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setupViews()
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "месторасположение")?.withTintColor(.black),
            style: .done,
            target: self,
            action: #selector(rightBarButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "бургер")?.withTintColor(.black, renderingMode: .alwaysTemplate),
            style: .done,
            target: self,
            action: #selector(leftBarButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.tableView.separatorColor = .clear
        self.tableView.showsVerticalScrollIndicator = false
        
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.twentyFourHoursHeaderView.buttonAction = self.buttonAction
                
        self.view.addSubview(scrollView)
        self.view.addSubview(plusImageView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(pageConrol)
        containerView.addSubview(informationStackView)
        containerView.addSubview(twentyFourHoursHeaderView)
        containerView.addSubview(collectionView)
        containerView.addSubview(tableView)
        
        informationStackView.addSubview(elipseImageView)
        informationStackView.addSubview(secondStackView)
        informationStackView.addSubview(sunriseTimeLabel)
        informationStackView.addSubview(sunsetTimeLabel)
        informationStackView.addSubview(sunriseImageView)
        informationStackView.addSubview(sunsetImageView)
        
        secondStackView.addArrangedSubview(graduationsLabel)
        secondStackView.addArrangedSubview(graduationNowLabel)
        secondStackView.addArrangedSubview(textLabel)
        secondStackView.addArrangedSubview(bigGroupeStackView)
        secondStackView.addArrangedSubview(informationLabel)
        
        firstGroupeStackView.addArrangedSubview(cloudyImageView)
        firstGroupeStackView.addArrangedSubview(numberLabel)
        
        secondGroupeStackView.addArrangedSubview(windImageView)
        secondGroupeStackView.addArrangedSubview(windSpeedLabel)
        
        thirdGroupeStackView.addArrangedSubview(humidityImageView)
        thirdGroupeStackView.addArrangedSubview(humidityLabel)
        
        bigGroupeStackView.addArrangedSubview(firstGroupeStackView)
        bigGroupeStackView.addArrangedSubview(secondGroupeStackView)
        bigGroupeStackView.addArrangedSubview(thirdGroupeStackView)
        
        plusImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.leading.trailing.width.equalTo(self.view)
        }
        
        secondStackView.snp.makeConstraints { make in
            make.width.equalTo(205)
            make.centerX.equalToSuperview()
            make.top.equalTo(elipseImageView).inset(30)
            make.bottom.equalToSuperview().inset(15)
        }
        
        pageConrol.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        informationStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(pageConrol.snp.bottom).inset(-17)
            make.height.equalTo(informationStackView.snp.width).multipliedBy(1/1.5)
        }
        
        elipseImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(17)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(elipseImageView.snp.width).multipliedBy(0.5)
        }
        
        sunriseImageView.snp.makeConstraints { make in
            make.height.width.equalTo(17)
            make.centerX.equalTo(elipseImageView.snp.leading)
            make.top.equalTo(elipseImageView.snp.bottom).inset(-5)
        }
        
        sunsetImageView.snp.makeConstraints { make in
            make.height.width.equalTo(17)
            make.centerX.equalTo(elipseImageView.snp.trailing)
            make.top.equalTo(elipseImageView.snp.bottom).inset(-5)
        }
        
        graduationsLabel.snp.makeConstraints { make in
            make.height.equalTo(graduationNowLabel)
            make.height.equalTo(textLabel)
            make.height.equalTo(bigGroupeStackView)
            make.height.equalTo(informationLabel)
        }
        
        bigGroupeStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        firstGroupeStackView.snp.makeConstraints { make in
            make.width.equalTo(45)
        }

        secondGroupeStackView.snp.makeConstraints { make in
            make.width.equalTo(90)
        }

        thirdGroupeStackView.snp.makeConstraints { make in
            make.width.equalTo(55)
        }

        sunriseTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(elipseImageView.snp.leading)
            make.top.equalTo(sunriseImageView.snp.bottom).inset(-5)
        }

        sunsetTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(elipseImageView.snp.trailing)
            make.top.equalTo(sunsetImageView.snp.bottom).inset(-5)
        }
        
        twentyFourHoursHeaderView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(informationStackView.snp.bottom).inset(-30)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(twentyFourHoursHeaderView.snp.bottom).inset(-10)
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(130)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).inset(-10)
            make.bottom.equalToSuperview()
            make.bottom.equalTo(self.view)
        }
        
        cloudyImageView.snp.makeConstraints { make in
            make.width.equalTo(26)
        }
        
        windImageView.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        humidityImageView.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
                        
    }
    
    private func buttonAction() {
        
        if self.pageConrol.numberOfPages - 1 <= 0 { return }
        
        self.viewModel.pushTwentyFourHours(index: self.pageConrol.currentPage - 1)
        
    }
    
    private func getInformation() {
        
        let informationData = self.viewModel.getInformationData(index: self.pageConrol.currentPage - 1)
        
        let citysName = self.viewModel.getCityNames(index: self.pageConrol.currentPage - 1)
        
        DispatchQueue.main.async { [ weak self ] in
            
            guard let self = self else { return }
            
            self.pageConrol.numberOfPages = self.viewModel.getCitysCount() + 1
            self.pageConrol.currentPage = self.pageConrol.numberOfPages > 1 ? 1 : 0
            self.pageControllDidUse(self.pageConrol)
                                
            self.graduationsLabel.text = "\(informationData.lowlestGraduation)°/\(informationData.bigestGraduation)°"
            self.graduationNowLabel.text = "\(informationData.nowGraduation)°"
            self.textLabel.text = informationData.text
            self.numberLabel.text = "\(informationData.number)"
            self.windSpeedLabel.text = "\(informationData.windSpeed)\(self.viewModel.isMetric() ? "m/s" : "mi/h")"
            self.humidityLabel.text = "\(informationData.humidityProcent)%"
            self.sunriseTimeLabel.text = informationData.sunriseTime
            self.sunsetTimeLabel.text = informationData.sunsetTime
            self.informationLabel.text = informationData.informaton
            
            self.tableView.reloadData()
            self.collectionView.reloadData()
            
            if self.pageConrol.numberOfPages - 1 < 0 { return }
            
            self.navigationItem.title = citysName
            
        }
                
    }
    
    private func setupValues() {
        
        let informationData = self.viewModel.getInformationData(index: self.pageConrol.currentPage - 1)
        let citysName = self.viewModel.getCityNames(index: self.pageConrol.currentPage - 1)
        
        DispatchQueue.main.async { [ weak self ] in
            
            guard let self = self else { return }
                                                                    
            self.graduationsLabel.text = "\(informationData.lowlestGraduation)°/\(informationData.bigestGraduation)°"
            self.graduationNowLabel.text = "\(informationData.nowGraduation)°"
            self.textLabel.text = informationData.text
            self.numberLabel.text = "\(informationData.number)"
            self.windSpeedLabel.text = "\(informationData.windSpeed)\(self.viewModel.isMetric() ? "m/s" : "mi/h")"
            self.humidityLabel.text = "\(informationData.humidityProcent)%"
            self.sunriseTimeLabel.text = informationData.sunriseTime
            self.sunsetTimeLabel.text = informationData.sunsetTime
            self.informationLabel.text = informationData.informaton
            
            self.navigationItem.title = citysName
            
            self.tableView.reloadData()
            self.collectionView.reloadData()
            
        }
        
    }
    
    @objc private func pageControllDidUse(_ sender: UIPageControl) {
            
        if sender.currentPage == 0 {
            
            self.plusImageView.isHidden = false
            
            self.tableView.isHidden = true
            self.collectionView.isHidden = true
            self.informationStackView.isHidden = true
            self.twentyFourHoursHeaderView.isHidden = true
            
            self.navigationItem.title = ""
            
        } else {
            
            self.plusImageView.isHidden = true
            
            self.tableView.isHidden = false
            self.collectionView.isHidden = false
            self.informationStackView.isHidden = false
            self.twentyFourHoursHeaderView.isHidden = false
            
            self.setupValues()
            
        }
        
    }
    
    @objc private func rightBarButtonDidTap() {
        
        let alert = UIAlertController(title: "Введите название города", message: nil,
                                      preferredStyle: .alert)
        
        alert.addTextField { _ in }
        
        let actionFirst = UIAlertAction(title: "Сохранить", style: .cancel) { _ in
            
            if let text = alert.textFields?[0].text {
                
                self.viewModel.addCity(cityNamed: text)
                
            }
            
        }
        
        let actionSecond = UIAlertAction(title: "Закрыть", style: .default)
        
        alert.addAction(actionFirst)
        alert.addAction(actionSecond)
        
        self.present(alert, animated: true)
        
    }
    
    @objc private func leftBarButtonDidTap() {
        self.viewModel.openSetting()
    }
    
}

extension HomepageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: OneHourCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: collectionViewCellId,
            for: indexPath
        ) as? OneHourCollectionViewCell else { return UICollectionViewCell() }

        cell.weather = self.viewModel.getTwentyFourHoursWeather(index: self.pageConrol.currentPage - 1)[indexPath.item]
        
        if cell.weather == self.viewModel.getTwentyFourHoursWeather(index: self.pageConrol.currentPage - 1).first {
            
            cell.isBlueBackground = true
            
        } else {
            cell.isBlueBackground = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if self.viewModel.getTwentyFourHoursWeather(index: self.pageConrol.currentPage - 1).count > 24 {
            return 24
        }
        
        return self.viewModel.getTwentyFourHoursWeather(index: self.pageConrol.currentPage - 1).count
        
    }
    
}

extension HomepageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let view: OneDayTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: tableViewCellId
        ) as? OneDayTableViewCell else { return UITableViewCell() }
        
        if self.pageConrol.currentPage - 1 < 0 ||
            self.pageConrol.numberOfPages - 1 != self.viewModel.getCitysCount() {
            return UITableViewCell()
        }
                        
        view.weather = viewModel.getTwentyFiveDaysWeather(index: self.pageConrol.currentPage - 1)[indexPath.row]
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                        
        return self.viewModel.getTwentyFiveDaysWeather(index: self.pageConrol.currentPage - 1).count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TwentyFiveDaysTableHeaderView()
        
        view.buttonAction = { [ weak self ] in self?.viewModel.pushTwentyFiveDays(
            index: (self?.pageConrol.currentPage ?? 1) - 1, dateIndex: 0) }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.viewModel.pushTwentyFiveDays(index: self.pageConrol.currentPage - 1,
                                          dateIndex: indexPath.row)
        
        print(indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23
    }
    
}
