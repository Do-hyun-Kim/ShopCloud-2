import UIKit
import RxSwift

var str = "Hello, playground"


var dispose = DisposeBag()

//main쓰레드에는 UI를 설정한다.
//just는 한번에 모든 데이터가 넘겨진다
//from은 데이터가 차례로 하나씩 인자에 데이터가 넘겨진다.
//



print("test")

Observable.just(["1","2","3"]).subscribe(onNext: { str in
    print(str)
}).disposed(by: dispose)



