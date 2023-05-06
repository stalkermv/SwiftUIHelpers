//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

#if canImport(UIKit)
import UIKit

public extension UIApplication {
    /// The key window of the application, if one exists.
    var keyWindow: UIWindow? {
        let scenes = connectedScenes.compactMap { $0 as? UIWindowScene }
        
        for scene in scenes {
            if let keyWindow = scene.windows.first(where: { $0.isKeyWindow }) {
                return keyWindow
            }
        }
        
        return nil
    }
    
    /// Ends editing on the key window of the application.
    func endEditing() {
        keyWindow?.endEditing(true)
    }
}
#endif
