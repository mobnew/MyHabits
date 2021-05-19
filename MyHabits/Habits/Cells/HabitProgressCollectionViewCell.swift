//
//  habitProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Alexey Kurazhov on 13.05.2021.
//

import UIKit

class HabitProgressCollectionViewCell: UICollectionViewCell {
    
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        return label
        
    }()
    
    
     let interestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
        
    }()
    

    
    
     let progressView: UIProgressView = {
        
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        progress.trackTintColor = .systemGray4
        progress.progressTintColor = .systemPurple
        
        return progress
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.addSubview(progressLabel)
        contentView.addSubview(interestLabel)
        contentView.addSubview(progressView)
        contentView.layer.cornerRadius = 8
        
        let constraints = [
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            interestLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            interestLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            
            progressView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
