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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: HomepageViewModel
    
    private let collectionViewCellId = "24hours"
    private let collectionViewHeaderId = "headerCollectionView"
    private let tableViewCellId = "25days"
    
    private let pageConrol: UIPageControl = {
        let view = UIPageControl()
        
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .systemGray2
        view.numberOfPages = 2
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
        label.text = "7°/13°"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let graduationNowLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "13°"
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Возможен небольшой дождь"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bigGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 19
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    
    private let thirdGroupeStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 5
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
        
        label.text = "0"
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
        
        label.text = "3 м/с"
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
        
        label.text = "75%"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "05:41"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "19:31"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        
        label.text = "17:48,  пт 16 апреля"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: 42, height: 84)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            OneHourCollectionViewCell.self,
            forCellWithReuseIdentifier: collectionViewCellId
        )
        self.collectionView.register(
            TwentyHoursCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: collectionViewHeaderId
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
        self.navigationItem.title = "Moscow, Russia"
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
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
        
        self.tableView.separatorColor = .clear
        self.tableView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(pageConrol)
        containerView.addSubview(informationStackView)
        containerView.addSubview(collectionView)
        containerView.addSubview(tableView)
        
        informationStackView.addSubview(elipseImageView)
        informationStackView.addSubview(sunriseImageView)
        informationStackView.addSubview(sunsetImageView)
        informationStackView.addSubview(graduationsLabel)
        informationStackView.addSubview(graduationNowLabel)
        informationStackView.addSubview(textLabel)
        informationStackView.addSubview(bigGroupeStackView)
        informationStackView.addSubview(sunriseTimeLabel)
        informationStackView.addSubview(sunsetTimeLabel)
        informationStackView.addSubview(informationLabel)
        
        firstGroupeStackView.addArrangedSubview(cloudyImageView)
        firstGroupeStackView.addArrangedSubview(numberLabel)
        
        secondGroupeStackView.addArrangedSubview(windImageView)
        secondGroupeStackView.addArrangedSubview(windSpeedLabel)
        
        thirdGroupeStackView.addArrangedSubview(humidityImageView)
        thirdGroupeStackView.addArrangedSubview(humidityLabel)
        
        bigGroupeStackView.addArrangedSubview(firstGroupeStackView)
        bigGroupeStackView.addArrangedSubview(secondGroupeStackView)
        bigGroupeStackView.addArrangedSubview(thirdGroupeStackView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.leading.trailing.width.equalTo(self.view)
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
            make.centerX.equalToSuperview()
            make.top.equalTo(elipseImageView).inset(16)
            make.width.equalToSuperview().multipliedBy(0.13)
        }
        
        graduationNowLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(graduationsLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(graduationsLabel)
            make.height.equalTo(graduationNowLabel.snp.width)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(elipseImageView).inset(27)
            make.top.equalTo(graduationNowLabel.snp.bottom).inset(-5)
        }
        
        bigGroupeStackView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(78)
            make.top.equalTo(textLabel.snp.bottom).inset(-18)
            make.height.equalTo(30)
        }
        
        sunriseTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(elipseImageView.snp.leading)
            make.top.equalTo(sunriseImageView.snp.bottom).inset(-5)
        }
        
        sunsetTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(elipseImageView.snp.trailing)
            make.top.equalTo(sunsetImageView.snp.bottom).inset(-5)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(96)
            make.top.equalTo(bigGroupeStackView.snp.bottom).inset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(informationStackView.snp.bottom).inset(-30)
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(84)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).inset(-40)
            make.bottom.equalToSuperview()
            make.bottom.equalTo(self.view)
        }
        
    }
    
    @objc private func rightBarButtonDidTap() {
        print("right button taped")
    }
    
    @objc private func leftBarButtonDidTap() {
        print("left button taped")
    }
    
}

extension HomepageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: OneHourCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: collectionViewCellId,
            for: indexPath
        ) as? OneHourCollectionViewCell else { return UICollectionViewCell() }

        cell.weather = self.viewModel.getTwentyFourHoursWeather()[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(self.viewModel.getTwentyFourHoursWeather().count)
        
        return self.viewModel.getTwentyFourHoursWeather().count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: collectionViewHeaderId,
            for: indexPath
        ) as? TwentyHoursCollectionReusableView else { return UICollectionReusableView() }
        
        view.buttonAction = viewModel.pushTwentyFourHours
        
        return view
    }
    
}

extension HomepageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let view: OneDayTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: tableViewCellId
        ) as? OneDayTableViewCell else { return UITableViewCell() }
                
        view.weather = viewModel.getTwentyFiveDaysWeather()[indexPath.row]
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTwentyFiveDaysWeather().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TwentyFiveDaysTableHeaderView()
        
        view.buttonAction = viewModel.openTwentyFiveDays
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.pushOneHourInformation()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23
    }
    
}
