import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        
        let METHOD_CHANNEL_NAME = "com.example.verygoodcore.pinapp_challenge/api"
        
        let apiChannel = FlutterMethodChannel(
            name: METHOD_CHANNEL_NAME,
            binaryMessenger: controller.binaryMessenger)
        
        apiChannel.setMethodCallHandler  { [weak self] (call, result) in
            
            switch(call.method) {
            case "getPostComments":
                if let args = call.arguments as? [String: Any], let postId = args["postId"] as? Int {
                    self?.getPostComments(for: postId, result: result)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "El Post ID debe ser un número entero", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getPostComments(for postId: Int, result: @escaping FlutterResult) {
        let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        guard let url = URL(string: urlString) else {
            result(FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                result(FlutterError(code: "NETWORK_ERROR", message: error.localizedDescription, details: nil))
                return
            }
            guard let data = data else {
                result(FlutterError(code: "NO_DATA", message: "No data received", details: nil))
                return
            }
            do {
                let comments = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                result(comments)
            } catch {
                result(FlutterError(code: "JSON_ERROR", message: "Failed to parse JSON", details: nil))
            }
        }
        task.resume()
    }
}

