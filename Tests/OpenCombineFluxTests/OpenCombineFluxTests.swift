import XCTest
@testable import OpenCombineFlux


//let store = Store<TestState>()
final class TestState: SimpleStateType, Equatable {
    
    static func == (lhs: TestState, rhs: TestState) -> Bool {
        return lhs.counter == rhs.counter
    }
    
    var counter: Int = 0
    
    enum Actions: Action {
        case increment,
        decrement
    }
    
    enum AsyncActions: AsyncAction {
        func execute(state: StateType?, dispatch: @escaping DispatchFunction) {
            print("Fetching something")
            DispatchQueue.main.async {
                print("Fetching something finished")
                dispatch(Actions.increment)
            }
        }
        
        case incrementAsync
    }
    
    static func reducer(state: TestState, action: Action) -> TestState {
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
        
        let expectation = XCTestExpectation.init()
        var totalActionsDispached = 0
        let cancellable = testStore.$state
            .sink { (state) in
            totalActionsDispached += 1
            let currentCounter = state.counter
            switch totalActionsDispached {
            case 2, 3, 5: XCTAssert(currentCounter == 1)
            case 1, 4: XCTAssert(currentCounter == 0)
            default:
                XCTAssert(false)
            }
            print("totalActionsDispached: \(totalActionsDispached)")
            print("currentCounter: \(currentCounter)")
            if totalActionsDispached > 4 {
                expectation.fulfill()
            }
        }
        testStore.dispatch(action: TestState.Actions.increment)
        testStore.dispatch(action: TestState.AsyncActions.incrementAsync)
        testStore.dispatch(action: TestState.Actions.decrement)
        
        wait(for: [expectation], timeout: 0.1)
        cancellable.cancel()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
