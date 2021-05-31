
import Foundation
import Combine

// MVVMでのRepositoryの役目として処理した結果をViewModelへ返す役割をしている
// この仕組みによって、ViewModelは与えられたデータが何の値かを意識せずにViewの状態管理に専念できる

// APIClientsを呼び出して、値を取得する
struct iTunesRepository {
    func fetchiTunes() -> AnyPublisher<iTunesModel, Error> {
        return iTunesAPIClient().get()
    }
}
