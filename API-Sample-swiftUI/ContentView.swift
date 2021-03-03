
import SwiftUI
import SDWebImageSwiftUI

//メイン画面
struct ContentView: View {
    //SwiftUIはstructなので基本的に変数の値は変更できない
    //しかし、varの前に@stateを付けることによって値の変更が可能になる、更にプロパティの値とUIの状態の同期が実現されViewが自動的に再描画される
    
    //空配列 ここにAPIデータを代入する
    @State private var iTunesModelInstance = [iTunesModel]()
    
    var body: some View {
        //テーブルView
        List(iTunesModelInstance, id: \.trackId) { result in
            //横スタック
            HStack(alignment: .center, spacing: 20) {
                WebImage(url: URL(string: result.artworkUrl60 ?? "noImage"))
                    .frame(width: 60, height: 60)
                    .cornerRadius(15)
                
                //縦スタック
                VStack(alignment: .leading) {
                    Text(result.trackName ?? "No TrackName")
                        .font(.headline)
                    Text(result.artistName ?? "No ArtistName")
                }
            }
            //スクリーン上にViewが表示された時に呼ばれる viewDidApper()
        }.onAppear(perform: {
            API.dataRequest { (results, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if results.isEmpty {
                    print("検索結果がありませんでした")
                    return
                }
                //空配列に代入する
                self.iTunesModelInstance = results
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
