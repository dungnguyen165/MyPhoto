//
//  Photo.swift
//  MyPhoto
//
//  Created by Dung Nguyen on 12/17/17.
//  Copyright © 2017 Dung Nguyen - s3598776. All rights reserved.
//

import UIKit
import os.log

class Photo: NSObject, NSCoding {

    
    //MARK: Properties
    var image: UIImage
    var imageDescription: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory .appendingPathComponent("photos")
    
    //MARK: Types
    struct PropertyKey {
        static let image = "image"
        static let imageDescription = "description"
    }
    

    
    init(image: UIImage, description: String) {
        self.image = image
        self.imageDescription = description
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(imageDescription, forKey: PropertyKey.imageDescription)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let imageDescription = aDecoder.decodeObject(forKey: PropertyKey.imageDescription) as? String else {
            os_log("Unable to decode the image description for a Photo object", log: OSLog.default, type: .debug)
            return nil
        }
        
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        
        self.init(image: image!, description: imageDescription)
        
    }
    
}
