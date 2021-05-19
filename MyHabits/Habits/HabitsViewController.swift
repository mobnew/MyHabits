//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Alexey Kurazhov on 12.05.2021.
//

import UIKit


class HabitsViewController: UIViewController {
    
    
    
    
//    MARK: Views
    
    private let progressCell = "progressCell"
    private let habitCell = "habitCell"
    
    let collectView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collect.backgroundColor = .systemGray5
        collect.translatesAutoresizingMaskIntoConstraints = false
        
      return collect
    }()

//    MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectView)


        collectView.register(HabitProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressCell")
        collectView.register(HabitItemCollectionViewCell.self, forCellWithReuseIdentifier: "habitCell")
        collectView.dataSource = self
        collectView.delegate = self
        

        
          setupConstraints()
    }
    
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectView.reloadData()
        
        let indexSet = IndexSet(integer: 1)
        collectView.reloadSections(indexSet)
    }
    
    
    func setupConstraints() {
        let constraints = [
            collectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    

}

//MARK:extension
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
        return 1
        } else
        {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! HabitProgressCollectionViewCell
            
            myCell.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
            myCell.interestLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100)) %"
            
            return myCell
        }
        else {
            
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as! HabitItemCollectionViewCell
            
            myCell.nameLabel.text = HabitsStore.shared.habits[indexPath.row].name
            myCell.nameLabel.textColor = HabitsStore.shared.habits[indexPath.row].color
            myCell.checkButton.layer.borderColor = HabitsStore.shared.habits[indexPath.row].color.cgColor
            myCell.timeLabel.text = HabitsStore.shared.habits[indexPath.row].dateString
            myCell.countLabel.text = "Счетчик: \(HabitsStore.shared.habits[indexPath.row].trackDates.count)"
            
            
            if HabitsStore.shared.habits[indexPath.row].isAlreadyTakenToday {
                myCell.checkButton.backgroundColor = UIColor(cgColor: myCell.checkButton.layer.borderColor!)
                myCell.checkButton.tintColor = UIColor(cgColor: myCell.checkButton.layer.borderColor!)
                myCell.checkButton.setImage(.checkmark, for: .normal)
                
            } else {
                myCell.checkButton.tag = indexPath.row
            myCell.checkButton.addTarget(self, action: #selector(btnpressed1(sender:)), for: .touchUpInside)
                
            }
            return myCell
        }
         
        
        
    }
    
    
    @objc func btnpressed1(sender: UIButton!)  {
        
        
        sender.backgroundColor = UIColor(cgColor: sender.layer.borderColor!)
        sender.tintColor = UIColor(cgColor: sender.layer.borderColor!)
        sender.setImage(.checkmark, for: .normal)
        
        if !HabitsStore.shared.habits[sender.tag].isAlreadyTakenToday {
        HabitsStore.shared.track(HabitsStore.shared.habits[sender.tag])
        }
        
        let indexSet = IndexSet(integer: 0)
        collectView.reloadSections(indexSet)

        
        
        
   }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    
}
    
    
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
        return .init(width: (collectionView.bounds.width - 32), height: 60)
        }
           else
        {
            return .init(width: (collectionView.bounds.width - 32), height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 12, right: 16)
        } else {
            return UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let detailVC = self.storyboard?.instantiateViewController(identifier: "detail") as? HabitDetailsViewController else { return }
        detailVC.habitID = indexPath.row
                
        show(detailVC, sender: nil)
    }
    

    
    
}



