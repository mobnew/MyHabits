//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Alexey Kurazhov on 18.05.2021.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
     let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        return label
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dayLabel)
        
    
        
        let constraints = [
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: 44)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
