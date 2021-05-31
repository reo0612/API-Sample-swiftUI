
import SwiftUI
import Combine

// メイン画面
struct ContentView: View {
    // SwiftUIはstructなので基本的に変数の値は変更できない
    // しかし、varの前に@stateを付けることによって値の変更が可能になり
    // プロパティの値とUIの状態の同期が実現されViewが自動的に再描画される
    // @State private var hogehoge = "hoge"
    
    // ContentViewModel内の特定のプロパティを監視したい場合は@StateObjectを付ける
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            switch viewModel.status {
            case .idle, .loading:
                let progressViewMessage = "loding..."
                ProgressView(progressViewMessage)
                
            case .failure(let error):
                Text(error.localizedDescription)
                Button {
                    viewModel.tapRetryButton()
                    
                } label: {
                    Text("Retry")
                }
                .padding(8)
                
            case .success(let itunesModel):
                if itunesModel.results.isEmpty {
                    let isEmptyText = "No Results"
                    Text(isEmptyText)
                        .bold()
                    
                }else {
                    List {
                        ForEach(itunesModel.results, id: \.trackId) { result in
                            ListRow(result: result)
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.onApper()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
