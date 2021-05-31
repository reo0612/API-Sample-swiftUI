
import Foundation
import Combine

// APIを叩いて値を取得する
struct iTunesAPIClient {
    
    func get() -> AnyPublisher<iTunesModel, Error> {
        let url = URL(string: "https://itunes.apple.com/search?term=mrs.greenapple&country=jp&media=music")!
        var urlRequest = URLRequest(url: url)
        let httpMethod = "GET"
        urlRequest.httpMethod = httpMethod
        
        // Publisher -> イベントの発行者
        // Subscriber -> イベントの購読者
        
        // Publisherを作成する
        // このPublisherをsubscribeすることで、通信が完了したタイミングでSubscriber内でイベントを処理できる
        return URLSession.shared.dataTaskPublisher(for: urlRequest).tryMap { element -> Data in
            // tryMap(operator)によって流れてくる要素を他の型に加工したり、エラーをthrowすることができる
            guard
                let responce = element.response as? HTTPURLResponse,
                responce.statusCode == 200 else{
                // 今回はhttpのstatusCodeが200以外の場合は異常とみなしてエラーを返して
                throw URLError(.badServerResponse)
            }
            // それ以外の場合はresponseのdataのみを返す
            return element.data
        }
        .decode(type: iTunesModel.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
        
        // 最終的に.eraseToAnyPublisher()によって型をAnyPubliserに変換する必要がある
        // 理由としては『外部でPublisherを受け渡したいから』である
        // AnyPubliserに変換することによって例えば、新しくAPIClientでpublisherの実装を変更した時に型が変わってしまっても
        // 型をAnyPubliserで統一しているため、外部で影響がでない
        // なのでAnyPubliserに変換して型を隠蔽してあげるのが良い
    }
}
