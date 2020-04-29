import XCTest
@testable import OpenCombineFlux


//let store = Store<TestState>()
struct TestState: SimpleStateType {
    
    var counter: Int = 0
    
    enum Actions: Action {
        case increment,
        decrement
    }
    
    static func reducer(state: TestState, action: Action) -> TestState {
        var state = state
        switch action {
        case Actions.increment :
            state.counter += 1
        case Actions.decrement :
            state.counter -= 1
        default: break
        }
        return state
    }
}

final class OpenCombineFluxTests: XCTestCase {
    func testExample() {
        let testStore = TestState.newStore()
        let any = testStore.$state.sink { (state) in
                   print("new state: \(state)")
               }
        testStore.dispatch(action: TestState.Actions.increment)
        testStore.dispatch(action: TestState.Actions.increment)
        testStore.dispatch(action: TestState.Actions.increment)
        testStore.dispatch(action: TestState.Actions.decrement)
       
        print(testStore.state.counter)
        any.cancel()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
