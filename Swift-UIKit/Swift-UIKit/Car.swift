//
//  Car.swift
//  test
//
//  Created by qwe on 10/18/23.
//

import UIKit

class Car: UICollectionViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carType: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var waitingTime: UILabel!
    @IBOutlet weak var info: UIImageView!
    @IBOutlet weak var seat: UILabel!
    @IBOutlet weak var view: UIView!
    
    func setShadow(applyShadow : Bool) {
//        if applyShadow {
//            self.layer.shadowOffset = CGSize.zero
//            self.layer.shadowColor = UIColor.darkGray.cgColor
//            self.layer.shadowOpacity = 0.5
//            self.layer.shadowRadius = 2
//            self.layer.masksToBounds = false
//            self.clipsToBounds = false
//        } else {
//            self.layer.shadowRadius = 15
//            self.layer.shadowColor = UIColor.clear.cgColor
//        }
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public var carInfo = CarModel(){
        didSet{
            self.view.layer.cornerRadius = 15
            self.layer.masksToBounds = true
            self.layer.backgroundColor = UIColor.clear.cgColor
            self.view.layer.backgroundColor = UIColorFromRGB(rgbValue: 0x272928).cgColor
            
            self.carType.textColor = UIColorFromRGB(rgbValue: 0xffffff)
            self.carPrice.textColor = UIColorFromRGB(rgbValue: 0x43B02A)
            self.waitingTime.textColor = UIColorFromRGB(rgbValue: 0xffffff)
            self.seat.textColor = UIColorFromRGB(rgbValue: 0xffffff)
            
            self.setShadow(applyShadow: true)

            
            if let carTypeValue = carInfo?.carType{
                carType.text = carTypeValue
            }
            
            if let waitingTimeValue = carInfo?.waitTime{
                waitingTime.text = waitingTimeValue
            }
            
            if let carImageUrl = carInfo?.carImage{
                carImage.image = carImageUrl
            }
            
            if let carPriceValue = carInfo?.carPrice{
                carPrice.text = carPriceValue
            }
            
            if let seatValue = carInfo?.seat{
                seat.text = seatValue
            }
        }
    }
}
