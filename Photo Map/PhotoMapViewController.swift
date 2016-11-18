//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                              MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(sfRegion, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCameraButtonClicked(_ sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
//        if UIImagePickerController.isSourceTypeAvailable() {
//            vc.sourceType = UIImagePickerControllerSourceType.camera
//        } else {
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]) {
        
        print("Image picker delegate")
        // Get the image captured by the UIImagePickerController
        let originalImage = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = didFinishPickingMediaWithInfo[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: {
            print("Perform segue")
            self.performSegue(withIdentifier: "tagSegue", sender: nil)
        })
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        print("Cancel clicked")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("prepare for segue")
        
        let navigationController = segue.destination as! UINavigationController
        let locationViewController = navigationController.viewControllers[0] as! LocationsViewController
        locationViewController.delegate = self
    }
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        print("Location delegate called")
    }
}
