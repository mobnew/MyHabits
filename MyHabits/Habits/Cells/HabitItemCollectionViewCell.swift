//
//  HabitItemCollectionViewCell.swift
//  MyHabits
//
//  Created by Alexey Kurazhov on 14.05.2021.
//

import UIKit

class HabitItemCollectionViewCell: UICollectionViewCell {
    
     let nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        

        
        return label
    }()
    
     let timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return label
    }()
    
     let countLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        

        
        return label
    }()
    
    
     var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 18
        button.contentMode = .scaleAspectFit
        
        
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        contentView.addSubview(checkButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(countLabel)
       
        
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        
        
        
        let constraints = [
            
            
                            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -26),

            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

           
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            
            
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 36),
            checkButton.widthAnchor.constraint(equalToConstant: 36),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26)
            
            
            
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
