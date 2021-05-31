
import Foundation
import Combine

// APIを叩いて値を取得する
struct iTunesAPIClient {
    
    func get() -> AnyPublisher<iTunesModel, Error> {
        let url = URL(string: "https://itunes.apple.com/search?term=mrs.greenapple&country=jp&media=music")!
        var urlRequest = URLRequest(url: url)
        let httpMethod = "GET"
        urlRequest.httpMethod = httpMethod
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest).tryMap { element -> Data in
            guard
                let responce = element.response as? HTTPURLResponse,
                responce.statusCode == 200 else{
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: iTunesModel.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
