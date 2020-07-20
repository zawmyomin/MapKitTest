//
//  MapKitVC.swift
//  Test
//
//  Created by Justin Zaw on 23/06/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SDWebImage
import GoogleSignIn

class MapKitVC: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapContainer: UIView!
    
    var mapView = MKMapView()
    var landmarks: [LandMark] = [LandMark]()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.backgroundColor = .white
        return view
    }()
    
    let cellId = "cellId"
    let defaults = UserDefaults.standard
    
    let infoView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let subView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let imgUser: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        return img
    }()
    
    let lblName : UILabel = {
       let lbl = UILabel()
        lbl.text = "Name : Hennery"
        lbl.textAlignment = .left
        lbl.textColor = .gray
        return lbl
    }()
    
    let lblNumber : UILabel = {
       let lbl = UILabel()
        lbl.text = "Job Number : 039920"
        lbl.textAlignment = .left
        lbl.textColor = .gray
        return lbl
    }()
    
    let searchView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    let lblSearchName : UILabel = {
       let lbl = UILabel()
        lbl.text = "Job Number : 039920"
        lbl.textAlignment = .left
        lbl.textColor = .gray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lblSearchTitle : UILabel = {
       let lbl = UILabel()
        lbl.text = "Job Number : 039920"
        lbl.textAlignment = .left
        lbl.textColor = .gray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let closeBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.addTarget(self, action: #selector(closeResult), for: .touchUpInside)
        return btn
    }()
    
    let barView : UIView = {
           let view = UIView()
           view.backgroundColor = .systemRed
           return view
       }()
    
    
    var searchBar: UISearchBar!
    
    var jobLat : Double?
    var jobLong : Double?
    var jobName : String?
    var jobAddress : String?
    
    var location: CLLocation? = nil
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 5000
    var annotationTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupMap()
        setupUserInfoView()
        checkLocationService()
        checkLocaitonAuthorization()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLocationService()
        checkLocaitonAuthorization()
        setupSearchView()
    }
    
    func setupMap(){
        mapContainer.addSubview(mapView)
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        mapView.delegate = self
        
    }
    
    func setupUserInfoView(){
        
        view.addSubview(subView)
        subView.anchor(top: mapContainer.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 56)
        subView.layer.shadowOpacity = 5
        subView.layer.shadowOffset = .zero
        
          view.addSubview(infoView)
          infoView.layer.shadowOpacity = 0.2
          infoView.layer.shadowOffset = .zero
          infoView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 100)
          
          infoView.addSubview(imgUser)
          imgUser.clipsToBounds = true
          imgUser.layer.cornerRadius = 40
          imgUser.anchor(top: infoView.topAnchor, left: infoView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
          
          infoView.addSubview(lblName)
          lblName.anchor(top: infoView.topAnchor, left: imgUser.rightAnchor, bottom: nil, right: infoView.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
        
          infoView.addSubview(lblNumber)
          lblNumber.anchor(top: lblName.bottomAnchor, left: imgUser.rightAnchor, bottom: nil, right: infoView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
          
          
          lblName.text = defaults.string(forKey: "userName")
          let userImage = defaults.url(forKey: "userImage")
          imgUser.sd_setImage(with:userImage, completed: nil)
          
        setupSearchBar()

      }
    
    func setupNavigation(){
            navigationItem.title = "HAULIO"
            
           let button = UIButton(type: .custom)
           button.setImage(UIImage (named: "signOut"), for: .normal)
           let barButtonItem = UIBarButtonItem(customView: button)
           barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 67).isActive = true
           barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
           button.addTarget(self, action: #selector(goLogOut), for: .touchUpInside)
           navigationItem.rightBarButtonItems = [barButtonItem]
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "back"), for: .normal)
        
        leftBtn.contentMode = .scaleToFill
        leftBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        leftBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let leftbarBtn = UIBarButtonItem(customView: leftBtn)
        leftbarBtn.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        leftbarBtn.customView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        navigationItem.leftBarButtonItems = [leftbarBtn]
        
        view.addSubview(barView)
        barView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
       }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
       
       
       @objc func goLogOut(){
          showSignOutAlert()
       }
    
    
    func showSignOutAlert() {
          let alert = UIAlertController(title: "Haulio", message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)

          alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
              //Cancel Action
          }))
          alert.addAction(UIAlertAction(title: "Log Out",
                                        style: UIAlertAction.Style.destructive,
                                        handler: {(_: UIAlertAction!) in
                                          //Sign out action
                                          self.signOut()
                                          
          }))
          self.present(alert, animated: true, completion: nil)
      }
    
    func signOut(){
        navigationController?.popViewController(animated: false)
                      GIDSignIn.sharedInstance()?.signOut()
                      defaults.removeObject(forKey: "loginStatus")
    }
    
    func setupSearchBar(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.tintColor = .gray
        searchBar.placeholder = "Search"
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.clearButtonMode = .never
        
        subView.addSubview(searchBar)
        searchBar.anchor(top: subView.topAnchor, left: subView.leftAnchor, bottom: subView.bottomAnchor, right: subView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 56)
    }

    
    func getJobInfo(number:String,address:String,lat:Double,lon:Double,name:String){
        jobName = name
        jobAddress = address
        jobLat = lat
        jobLong = lon
        
        lblNumber.text = "Job number : \(number)"
        
        let jobLoc = MKPointAnnotation()
        jobLoc.title = name
        jobLoc.coordinate = CLLocationCoordinate2D(latitude:  jobLat!, longitude:  jobLong!)
        mapView.addAnnotation(jobLoc)
        
    }

    func setupLocationManager(){
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
       
           self.locationManager.distanceFilter = kCLDistanceFilterNone
           self.locationManager.requestWhenInUseAuthorization()
           self.locationManager.stopUpdatingLocation()
       }

       func checkLocationService(){
           if CLLocationManager.locationServicesEnabled() {
               setupLocationManager()
               checkLocaitonAuthorization()
           } else {
               
           }
       }
       
       func checkLocaitonAuthorization(){
           switch CLLocationManager.authorizationStatus() {
           case .authorizedWhenInUse:
               mapView.showsUserLocation = true
               centerViewOnUserLocation()
               locationManager.startUpdatingLocation()
           
           case .denied:
               break
           case .notDetermined:
               break
           case .restricted:
               break
           case .authorizedAlways:
               break
           default:
               break
           }
       }
       
       func centerViewOnUserLocation() {
           if let location = locationManager.location?.coordinate {
               let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
               mapView.setRegion(region, animated: true)
           }
       }
    
    
    func setupTableView(){
        view.addSubview(tableView)
        
        tableView.anchor(top: subView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 120)
        tableView.isHidden = true
        tableView.register(SearchCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    private func getNearByLandMarks(search: String){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error ) in
            if let response = response {
                let mapItems = response.mapItems
//                print("Map Data",mapItems)
                self.landmarks = mapItems.map{
                    LandMark(placemark: $0.placemark)
                    
                }
                
             self.tableView.reloadData()
          
                               
            }
            
        }
     
    }

//-remove annotation
    func removeSpecificAnnotation() {
        for annotation in self.mapView.annotations {
            if let title = annotation.title, title == annotationTitle {
                self.mapView.removeAnnotation(annotation)
            }
        }
    }
    
    
    func setupSearchView(){
        view.addSubview(searchView)
        searchView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 150)
        searchView.isHidden = true
        
        searchView.addSubview(lblSearchTitle)
        lblSearchTitle.anchor(top: searchView.topAnchor, left: searchView.leftAnchor, bottom: nil, right: searchView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 34, width: 0, height: 0)
        
        searchView.addSubview(lblSearchName)
        lblSearchName.anchor(top: lblSearchTitle.bottomAnchor, left: searchView.leftAnchor, bottom: nil, right: searchView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        searchView.addSubview(closeBtn)
        closeBtn.anchor(top: searchView.topAnchor, left: nil, bottom: nil, right: searchView.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 2, width: 30, height: 30)
    }
    
    
    @objc func closeResult(){
        locationManager.startUpdatingLocation()
        searchView.isHidden = true
        subView.isHidden = false
        removeSpecificAnnotation()
        centerViewOnUserLocation()
        searchBar.setShowsCancelButton(false, animated: false)
    }

}


extension MapKitVC : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocaitonAuthorization()
    }
    
}

extension MapKitVC : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.text = nil
        tableView.isHidden = true

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
            if searchText == "" || searchBar.text == nil {
                searchBar.setShowsCancelButton(false, animated: true)
                tableView.isHidden = true
                view.endEditing(true)
                   } else {

                    if searchText.count > 1 {
                        tableView.isHidden = false
                        if Connectivity.isConnectedToInternet(){
                            getNearByLandMarks(search: searchText)
                            
                            }else{
                                let alertController = UIAlertController(title: "Haulio", message: "No Internet Connection", preferredStyle: .alert)
                                let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                                    
                                    searchBar.searchTextField.text = nil
                                    self.tableView.isHidden = true
                                    searchBar.setShowsCancelButton(false, animated: true)
                                    searchBar.endEditing(true)
                                }
                                alertController.addAction(action1)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        
                        }else {
                            //

                        }
                   
                }

            }

    }
    
    

extension MapKitVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  landmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchCell
        cell.selectionStyle = .none
        cell.lblResult.text = landmarks[indexPath.row].name //"AMK HUB"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchView.isHidden = false
        tableView.isHidden = true
        subView.isHidden = true
        searchBar.endEditing(true)
        searchBar.searchTextField.text = nil
        
        let placeName = landmarks[indexPath.row].name
        let placeTitle = landmarks[indexPath.row].title
        let placeCoordinate = landmarks[indexPath.row].coordinate
        
        let annotation = MKPointAnnotation()
        annotation.title = placeName
        annotation.coordinate = placeCoordinate
        mapView.addAnnotation(annotation)
        annotationTitle = placeName
        
        let region = MKCoordinateRegion.init(center: placeCoordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
       
        lblSearchName.text = "ADDRESS : \(placeTitle)"
        lblSearchTitle.text = "NAME : \(placeName)"
        
    }
}


