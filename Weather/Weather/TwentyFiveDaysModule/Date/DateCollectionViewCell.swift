//
//  DateCollectionViewCell.swift
//  Weather
//
//  Created by Artemiy Zuzin on 15.02.2022.
//

import UIKit
import SnapKit

final class DateCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var date: String? {
        
        didSet {
            
            guard let date = date else { return }
            
            self.dateLabel.text = date
            
        }
        
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupViews() {
        
        self.layer.cornerRadius = 5
        
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(6)
        }
        
    }
    
}
