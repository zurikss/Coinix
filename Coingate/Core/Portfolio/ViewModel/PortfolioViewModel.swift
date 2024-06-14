//
//  PortfolioViewModel.swift
//  Coingate
//
//  Created by Victor on 04/11/2023.
//

import SwiftUI
import Foundation

class PortfolioViewModel: ObservableObject {
    
    let manager = LocalFileManager.instance
    // we use UIImage when moving images within our apps architecture and data
    @Published var image: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    
    @Published var portfolioTextProfile: String = ""
    @Published var portfolioImageProfile: String = ""
    @Published var portfolioIconProfile: String = ""
    @Published var ifContentisTapped: Bool = false
    
    let defaults = UserDefaults.standard
    
    struct Keys {
        static let emojiProfile = "emojiProfile"
        static let imageProfile = "imageProfile"
        static let iconProfile = "iconProfile"

    }

    

 var memojis: [String] = [
            "memoji1",
            "memoji2",
            "memoji3",
            "memoji4",
            "memoji5",
            "memoji6",
            "memoji7",
            "memoji8",
            "memoji9",
            "memoji10",
            "memoji11",
            "memoji12",
            "memoji13",
            "memoji14",
            "memoji15",
            "memoji16",
            "memoji17",
            "memoji18",
            "memoji19",
            "memoji20",
            "memoji21",
            "memoji22",
            "memoji23",
            "memoji24",
            "memoji25",
            "memoji26",
            "memoji27",
            "memoji28"
        ]
    
    init() {
        //getImagesFromAssetsFolder()
        getMemojiFromFM()
        checkForSavedProfile()
    }
    
    func getImagesFromAssetsFolder() {
        var imageArray: [UIImage] = []
        
        for memojiName in memojis {
            if let image = UIImage(named: memojiName) {
                imageArray.append(image)
            }
        }
    }
    
     func getMemojiFromFM() {
        for memojiName in memojis {
            if let savedImage = manager.getImage(imageName: memojiName, folderName: "Memojis") {
                image = savedImage
                //print("Retrieved \(memojiName) from File Manager")
            } else {
                saveAllImagesToFolder()
                saveImage()
                print("Downloading Images Now")
            }
        }
    }

    func saveImage() {
        guard let image = image else { return }
        print(image)
    }
    
    func saveAllImagesToFolder() {
            for memojiName in memojis {
                if let image = UIImage(named: memojiName) {
                    manager.saveImage(image: image, imageName: memojiName, folderName: "Memojis")
                    //print("\(image) saved to file Manager")
                } else {
                    print("error saving to file manager")
                }
            }
        }
    
    func saveAllProfile() {
        defaults.setValue(portfolioIconProfile, forKey: Keys.iconProfile)
        defaults.setValue(portfolioTextProfile, forKey: Keys.emojiProfile)
        defaults.setValue(portfolioImageProfile, forKey: Keys.imageProfile)

    }
    
    func checkForSavedProfile() {
        let iconProfile = defaults.value(forKey: Keys.iconProfile) as? String ?? ""
        let emojiProfile = defaults.value(forKey: Keys.emojiProfile) as? String ?? ""
        let imagesProfile = defaults.value(forKey: Keys.imageProfile) as? String ?? ""

        portfolioIconProfile = iconProfile
        portfolioTextProfile = emojiProfile
        portfolioImageProfile = imagesProfile
        
    }
    
    

}
