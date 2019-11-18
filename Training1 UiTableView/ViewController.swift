//
//  ViewController.swift
//  Training1 UiTableView
//
//  Created by Gordan Saw on 15/11/2019.
//  Copyright © 2019 Gordan Saw. All rights reserved.
//

import UIKit

//Member Class
struct Member {
    public let id : Int
    public let name : String
    
    public init(id : Int, name : String){
        self.id = id
        self.name = name
    }
}

//Member Custom TableView Cell
class MemberCell : UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setMember(member : Member){
        idLabel.text = String (member.id)
        nameLabel.text = member.name
    }
}

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //UI Declaration
    @IBOutlet weak var memberTableView: UITableView!
    @IBOutlet weak var sortTypeLabel: UILabel!
    
    //Set Member Array List
    var members = [Member(id:1,name:"Shiro"),
                   Member(id:2,name:"Lina"),
                   Member(id:3,name:"Wakaba"),
                   Member(id:4,name:"Rin")]
    
    //Set Enum Sort Type List
    enum SortType : String{
        case ascendId = "Ascending Id"
        case ascendName = "Ascending Name"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortTypeLabel.text = SortType.ascendId.rawValue
    }
    
    @IBAction func sortAscOrderBtnClick(_ sender: UIButton) {
        sortTypeAlert()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member = members[indexPath.row]
        let memberCell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") as! MemberCell
        
        memberCell.setMember(member:member)
        
        return memberCell
    }
    
    // Order by SortType Function
    func sortAscOrderBy(sortType : SortType){
        switch sortType {
        case SortType.ascendId:
            let tempSortIdList = members.sorted(by: {$0.id < $1.id})
            members = tempSortIdList
            memberTableView.reloadData()
            break
            
        case SortType.ascendName:
            let tempSortNameList = members.sorted(by: {$0.name < $1.name})
            members = tempSortNameList
            memberTableView.reloadData()
            break
            
        default:
            let tempSortIdList = members.sorted(by: {$0.id < $1.id})
            members = tempSortIdList
            memberTableView.reloadData()
            break
        }
    }
    
    
   
    
    //Select Sort Type Alert Modal Popover
    func sortTypeAlert(){
        let sortTypeAlertController = UIAlertController(title: "Sort By", message:"", preferredStyle: .alert)
        
        let sortAscIdBtn = UIAlertAction(title: SortType.ascendId.rawValue, style: .default) {
            (action:UIAlertAction) in
            self.sortAscOrderBy(sortType: SortType.ascendId)
            self.sortTypeLabel.text = SortType.ascendId.rawValue
            //print("You've Sortby : AscendingOrderById");
        }
        
        let sortAscNameBtn = UIAlertAction(title: SortType.ascendName.rawValue, style: .default) {
            (action:UIAlertAction) in
            self.sortAscOrderBy(sortType: SortType.ascendName)
            self.sortTypeLabel.text = SortType.ascendName.rawValue
            //print("You've Sortby : AscendingOrderByName");
        }
        
        sortTypeAlertController.addAction(sortAscIdBtn)
        sortTypeAlertController.addAction(sortAscNameBtn)
        
        self.present(sortTypeAlertController, animated: true, completion: nil)
        
    }
    
    
}

