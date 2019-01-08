import Foundation
import UIKit

class FetchFilterOperation {
    //Take in a launch property and return an array of images
    func fetchFilter(flickRString : String, completion: @escaping ((_ sucess : Bool, _ photo : UIImage?) -> Void) ){
        let url = URL(string: flickRString)
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, _, error) in
            if let error = error {
                
                print(error.localizedDescription, "error from DataTask")
                completion(false, nil)
            }
            
            guard let data = data else {print("error getting data");completion(false, nil);return}
            
            guard let downloadedImage = UIImage(data: data) else {completion(false, nil) ; return}
            
            completion(true, downloadedImage)
        }
        dataTask.resume()
    }
}

