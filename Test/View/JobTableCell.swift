//
//  JobTableCell.swift
//  Test
//
//  Created by Justin Zaw on 22/04/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import UIKit

protocol JobNumberDelegate {
    func passData( name: String, number: String, lat:Double, long: Double, address: String)
}

class JobTableCell: UITableViewCell {
    
    var lblJobNumber : UILabel = {
        let lbl = UILabel()
        lbl.text = "Steve Job"
        lbl.textColor = .darkGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
       
        return lbl
    }() 
    
    var lblCompany : UILabel = {
        let lbl = UILabel()
        lbl.text = "Company : Sheng Shiong Warehouse"
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .gray
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 15)
        
        return lbl
         }()
    
    
    var lblAddress : UILabel = {
            let lbl = UILabel()
            lbl.text = "Address : 115A Commonwealth Drive, #05-01 Singapore 149596"
            lbl.numberOfLines = 0
            lbl.textAlignment = .left
            lbl.textColor = .gray
            lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 15)
            
            return lbl
             }()

    lazy var btnAccept : UIButton = {
       let btn = UIButton()
        btn.setTitle("Accept", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.backgroundColor  = .green
        return btn
    }()
    
    var delegate : JobNumberDelegate!
    var name : String?
    var address: String?
    var jobNumber: String?
    var lat: Double?
    var long: Double?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(jobNumber:String,address:String,lat:Double,lon:Double,name:String){
        self.name = name
        self.jobNumber = jobNumber
        self.address = address
        self.long = lon
        self.lat = lat
    }
    
    func setupUI(){
        backgroundColor = .white
        addSubview(btnAccept)
        btnAccept.layer.cornerRadius = 4
        btnAccept.layer.shadowOpacity = 0.2
        btnAccept.layer.shadowOffset = .zero
        btnAccept.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 100, height: 50)
        
        addSubview(lblJobNumber)
       
        lblJobNumber.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: btnAccept.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 30)
        
        addSubview(lblAddress)
        
        lblAddress.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 40)
        
        addSubview(lblCompany)
//        lblCompany.backgroundColor = .gray
        lblCompany.anchor(top: nil, left: leftAnchor, bottom: lblAddress.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 30)
        
        btnAccept.addTarget(self, action: #selector(getJobData), for: .touchUpInside)
       
    }
    
    @objc func getJobData(){
        delegate.passData(name: name!, number: jobNumber!, lat: lat!, long: long!, address: address!)
    }
    
    

}
