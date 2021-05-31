
import Foundation
import Combine

// ****Repositoryの責務*****
// ViewModelとAPIClientの仲介役
// APIClientを呼び出して、その結果をViewModelへ渡す
// この仕組みによって、ViewModelは与えられたデータが何の値かを意識せずにViewの状態管理に専念できる

struct iTunesRepository {
    func fetchiTunes() -> AnyPublisher<iTunesModel, Error> {
        return iTunesAPIClient().get()
    }
}
