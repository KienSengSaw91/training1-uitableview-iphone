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
    
    //Set Sort Type List
    let sortTypeList = ["AscendingOrderById","AscendingOrderByName"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //Sort Orderby Type Function
    func sortAscOrderBy(sortType : String?){
        switch sortType {
        case "AscendingOrderById":
            let tempSortIdList = members.sorted(by: {$0.id < $1.id})
            members = tempSortIdList
            memberTableView.reloadData()
            
            
        case "AscendingOrderByName":
            let tempSortNameList = members.sorted(by: {$0.name < $1.name})
            members = tempSortNameList
            memberTableView.reloadData()
            
            
        default:
            let tempSortIdList = members.sorted(by: {$0.id < $1.id})
            members = tempSortIdList
            memberTableView.reloadData()
            
        }
    }
    
    
    @IBAction func sortAscOrderBtnClick(_ sender: UIButton) {
        
        sortTypeAlert()
    }
    
    //Select Sort Type Alert ModalPopover
    func sortTypeAlert(){
        let sortTypeAlertController = UIAlertController(title: "Sort By", message:"", preferredStyle: .alert)
        
        let sortAscIdBtn = UIAlertAction(title: "Ascending Id", style: .default) {
            (action:UIAlertAction) in
            self.sortAscOrderBy(sortType: "AscendingOrderById")
            
            self.sortTypeLabel.text = "Ascending Id"
            //print("You've Sortby : AscendingOrderById");
        }
        
        let sortAscNameBtn = UIAlertAction(title: "Ascending Name", style: .default) {
            (action:UIAlertAction) in
            self.sortAscOrderBy(sortType: "AscendingOrderByName")
            self.sortTypeLabel.text = "Ascending Name"
            //print("You've Sortby : AscendingOrderByName");
        }
        
        
        sortTypeAlertController.addAction(sortAscIdBtn)
        sortTypeAlertController.addAction(sortAscNameBtn)
        
        self.present(sortTypeAlertController, animated: true, completion: nil)
        
    }
    
    
}

