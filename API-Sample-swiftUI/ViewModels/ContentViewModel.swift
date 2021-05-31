
import Foundation
import Combine

// viewからイベントを受け取ってiTunesRepositoryに値を取得させる
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
    // iTunesRepositoryから処理結果を取得し、@Publishedで監視しているstatusプロパティをViewに公開する
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
