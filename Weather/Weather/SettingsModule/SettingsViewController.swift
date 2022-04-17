//
//  SettingsViewController.swift
//  Weather
//
//  Created by Artemiy Zuzin on 21.02.2022.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: SettingsViewModel
        
    private let containerView: UIView = {
        let view = UIView()
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Настройки"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bigStackView: UIStackView = {
        let view = UIStackView()
        
        view.spacing = 20
        view.axis = .vertical
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
    
    private let temperatureTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Температура"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let temperatureSegmetalConroll: UISegmentedControl = {
        let view = UISegmentedControl(items: ["C", "F"])
        
        view.selectedSegmentTintColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        view.addTarget(self, action: #selector(didChangeFirst(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let windSpeedTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Скорость ветра"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windSpeedSegmetalConroll: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Mi", "Km"])
        
        view.selectedSegmentTintColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        view.addTarget(self, action: #selector(didChangeSecond(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Формта времени"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let timeSegmetalConroll: UISegmentedControl = {
        let view = UISegmentedControl(items: ["12", "24"])
        
        view.selectedSegmentTintColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        view.addTarget(self, action: #selector(didChangeThird(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let notificationsTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Уведомления"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let notificationsSegmetalConroll: UISegmentedControl = {
        let view = UISegmentedControl(items: ["On", "Off"])
        
        view.selectedSegmentTintColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        view.addTarget(self, action: #selector(didChangeFourth(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        
        button.tintColor = .white
        button.setTitle("Установить", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let select = viewModel.selectSettingsNow()
        
        self.temperatureSegmetalConroll.selectedSegmentIndex = select.temperature == "C" ? 0 : 1
        self.windSpeedSegmetalConroll.selectedSegmentIndex = select.speed == "Km" ? 1 : 0
        self.timeSegmetalConroll.selectedSegmentIndex = select.time == 24 ? 1 : 0
        self.notificationsSegmetalConroll.selectedSegmentIndex = select.notifications == true ? 0 : 1
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setupViews()
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        
        self.view.addSubview(containerView)
        
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(bigStackView)
        self.containerView.addSubview(saveButton)
        
        self.bigStackView.addArrangedSubview(firstStackView)
        self.bigStackView.addArrangedSubview(secondStackView)
        self.bigStackView.addArrangedSubview(thirdStackView)
        self.bigStackView.addArrangedSubview(fourthStackView)
        
        self.firstStackView.addSubview(temperatureTitleLabel)
        self.firstStackView.addSubview(temperatureSegmetalConroll)
        
        self.secondStackView.addSubview(windSpeedTitleLabel)
        self.secondStackView.addSubview(windSpeedSegmetalConroll)
        
        self.thirdStackView.addSubview(timeTitleLabel)
        self.thirdStackView.addSubview(timeSegmetalConroll)
        
        self.fourthStackView.addSubview(notificationsTitleLabel)
        self.fourthStackView.addSubview(notificationsSegmetalConroll)
                
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(27)
            make.centerY.equalToSuperview()
            make.height.equalTo(330)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        bigStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        firstStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview()
        }
        
        secondStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview()
        }
        
        thirdStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview()
        }
        
        fourthStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview()
        }
        
        temperatureTitleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        temperatureSegmetalConroll.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        windSpeedTitleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        windSpeedSegmetalConroll.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        timeTitleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        timeSegmetalConroll.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        notificationsTitleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        notificationsSegmetalConroll.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
    }
    
    @objc private func didChangeFirst(_ sender: UISegmentedControl) {
        self.viewModel.didChangeFirst(number: sender.selectedSegmentIndex)
    }
    
    @objc private func didChangeSecond(_ sender: UISegmentedControl) {
        self.viewModel.didChangeSecond(number: sender.selectedSegmentIndex)
    }
    
    @objc private func didChangeThird(_ sender: UISegmentedControl) {
        self.viewModel.didChangeThird(number: sender.selectedSegmentIndex)
    }
    
    @objc private func didChangeFourth(_ sender: UISegmentedControl) {
        self.viewModel.didChangeFourth(number: sender.selectedSegmentIndex)
    }
    
    @objc private func buttonDidTap() {
        self.viewModel.save()
    }
    
}
