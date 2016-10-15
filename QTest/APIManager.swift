//
//  APIManager.swift
//  QTest
//
//  Created by Shah Newaz Hossain on 10/15/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import TSMessages

let appDelegate = UIApplication.shared.delegate as! AppDelegate
private let BaseUrl: String = "http://aujamtanmeyah.org.sa/qtest/"
private let SecurityCode: String = "api#100#qtest*786!#102"

typealias SuccessCompletionHandler = (_ response: AnyObject) -> Void
typealias FailureCompletionHandler = (_ error: Error) -> Void

class APIManager: NSObject {
    
    static let sharedInstance : APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    func executePostRequest(urlString: String, parameters: Parameters, Success: @escaping SuccessCompletionHandler, Failure: @escaping FailureCompletionHandler) {
        var param = parameters
        param["security_code"] = SecurityCode
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: appDelegate.window!, animated: true)
        Alamofire.request(BaseUrl+urlString, method: .post, parameters: param).validate(contentType: ["application/json", "text/html"]).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                let error = response.result.error! as Error
                hud.hide(animated: true)
                Failure(error)
                print("Failure \(urlString) :\(response.response?.statusCode) \(error.localizedDescription)")
                TSMessage.showNotification(withTitle: error.localizedDescription, type: .error)
                return
            }
//
            print("Success \(urlString) : \(response.result.value)")
            hud.hide(animated: true)
            Success(response.result.value! as AnyObject)

            
//            switch response.result {
//            case .success:
//                print("Success \(urlString) : \(response.result.value)")
//                hud.hide(animated: true)
//                Success(response.result.value! as AnyObject)
//                break
//            case .failure(let error):
//                hud.hide(animated: true)
//                Failure(error)
//                print("Failure \(urlString) : \(error.localizedDescription)")
//                TSMessage.showNotification(withTitle: error.localizedDescription, type: .error)
//
//                break
//            }
//            guard response.error==nil else {
//                let error = response.error!
//                hud.hide(animated: true)
//                Failure(error)
//                print("Failure \(urlString) : \(error.localizedDescription)")
//                TSMessage.showNotification(withTitle: error.localizedDescription, type: .error)
//                return
//            }
            
//            let json = try? JSONSerialization.jsonObject(with: response.result.value!, options: .allowFragments)
//            print("Success \(urlString) : \(json)")
//            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
//
//                print("Data: \(utf8Text)")
//                hud.hide(animated: true)
//            }
        }
    }
    
}


//enum Suit {
//    case Spades, Hearts, Diamonds, Clubs
//    func simpleDescription() -> String {
//        switch self {
//        case .Spades:
//            return "spades"
//        case .Hearts:
//            return "hearts"
//        case .Diamonds:
//            return "diamonds"
//        case .Clubs:
//            return "clubs"
//        }
//    }
//}

//enum BackendError: Error {
//    case network(error: Error) // Capture any underlying Error from the URLSession API
//    case dataSerialization(error: Error)
//    case jsonSerialization(error: Error)
//    case xmlSerialization(error: Error)
//    case objectSerialization(reason: String)
//}
//
//protocol ResponseObjectSerializable {
//    init?(response: HTTPURLResponse, representation: Any)
//}
//
//extension DataRequest {
//    func responseObject<T: ResponseObjectSerializable>(
//        queue: DispatchQueue? = nil,
//        completionHandler: @escaping (DataResponse<T>) -> Void)
//        -> Self
//    {
//        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
//            guard error == nil else { return .failure(BackendError.network(error: error!)) }
//            
//            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
//            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
//            
//            guard case let .success(jsonObject) = result else {
//                return .failure(BackendError.jsonSerialization(error: result.error!))
//            }
//            
//            guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
//                return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
//            }
//            
//            return .success(responseObject)
//        }
//        
//        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
//    }
//}

