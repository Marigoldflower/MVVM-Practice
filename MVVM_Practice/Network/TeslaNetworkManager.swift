//
//  TeslaNetworkManager.swift
//  MVVM_Practice
//
//  Created by 황홍필 on 2023/05/20.
//

import Foundation
import Alamofire


class TeslaNetworkManager {
    
    static let shared = TeslaNetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    
    // 지금 문제가 네트워크 처리가 끝나지도 않았는데 코드가 실행되어서 네트워크 값이 들어오지 못하는 상태이다. 
    func fetchNetworkData(completion: @escaping ([Article]) -> ()) {
        
        let url = "https://newsapi.org/v2/everything?q=tesla&from=2023-05-16&sortBy=publishedAt&apiKey=317fa039aea64f5383d896dca09a10e6"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: TeslaModel.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.articles)
                print("네트워크가 성공적으로 처리되었습니다!")
            case .failure(let error):
                print(error)
                print("네트워크 처리가 실패하였습니다 ㅠㅠ")
            }
        }
    }
}
