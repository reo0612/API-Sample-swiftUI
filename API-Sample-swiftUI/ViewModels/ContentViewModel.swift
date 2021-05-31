
import Foundation
import Combine

// ****ViewModelの責務*****
// viewから入力を受け取ってRepositoryに値を取得させる
// ViewのStateを管理する
// Stateを加工してViewへ出力する

// Modelに依存しているが、その逆はない

final class ContentViewModel: ObservableObject {
    // @Publishedによって値の変更を監視する
    // ObservableObjectを準拠しないといけない
    @Published private(set) var status: APIStatus<iTunesModel> = .idle
    private var canselales = Set<AnyCancellable>()
    
    func onApper() {
        load()
    }
    
    func tapRetryButton() {
        load()
    }
    
    // Repositoryから結果(Publisher)を貰って、それをsubscriber(sink)でsubscribeする
    // そして、取得した値を@Publishedで公開しているstatusプロパティによってViewのStateを管理
    private func load() {
        iTunesRepository().fetchiTunes()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveRequest:  {[weak self] _ in
                self?.status = .loading
                
            }).sink {[weak self] complition in
                switch complition {
                case .finished:
                    print(complition)
                    
                case .failure(let error):
                    print(error)
                    self?.status = .failure(error)
                }
                
            } receiveValue: {[weak self] iTunesModel in
                self?.status = .success(iTunesModel)
                
            }.store(in: &canselales)
        
    }
}
