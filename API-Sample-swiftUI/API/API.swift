
import Foundation

struct API {
    
    //API通信メソッド
    static func dataRequest( complition: (([iTunesModel], Error?) -> Void)? = nil) {
        
        let apiUrlStr = "https://itunes.apple.com/search?term=mrs.greenapple&country=jp&media=music"
        
        //URL取得
        guard let apiUrl = URL(string: apiUrlStr) else {
            print("URLが取得できませんでした")
            return
        }
        //URLリクエストの生成
        let request = URLRequest(url: apiUrl)
        
        //URLにアクセスする
        URLSession.shared.dataTask(with: request) { data, responce, error in
            //エラー処理
            if let error = error {
                complition?([], error)
                return
            }
            print("\(data as Any)")
            
            //データ取得、json文字列をデコードする
            guard
                let data = data,
                let decodeResponce = try? JSONDecoder().decode(Response.self, from: data) else {
                print("デコード失敗")
                return
            }
            //API通信で取得したデータ配列を定数化
            let results = decodeResponce.results
            
            complition?(results, nil)
            
        }.resume()
    }
}
