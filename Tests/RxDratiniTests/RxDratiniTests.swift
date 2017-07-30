import XCTest
import Dratini
import RxSwift
@testable import RxDratini

private struct TestGetResponse: Response {
    let stringParam: String
    let chineseParam: String
    let intParam: Int
    let optionalParam: String?
    
    init?(data: ResponseData, response: URLResponse) {
        guard let args = data.jsonObject["args"] as? [String: Any],
            let stringParam = args["string_param"] as? String,
            let chineseParam = args["chinese_param"] as? String,
            let intParamString = args["int_param"] as? String,
            let intParam = Int(intParamString) else {
                return nil
        }
        self.stringParam = stringParam
        self.chineseParam = chineseParam
        self.intParam = intParam
        self.optionalParam = args["optional_param"] as? String
    }
}

private struct TestGetQueryString: DefaultQueryString {
    let stringParam: String
    let chineseParam: String
    let intParam: Int
    let optionalParam: String?
}

private struct TestGetRequest: Request {
    typealias ParametersType = TestGetQueryString
    typealias ResponseType = TestGetResponse
    
    var parameters: TestGetQueryString
    
    func path() -> String {
        return "/get"
    }
    
    func method() -> HTTPMethod {
        return .get
    }
}

class RxDratiniTests: XCTestCase {
    private lazy var requestQueue: RequestQueue = {
        return RequestQueue(baseURL: URL(string: "http://httpbin.org")!)
    }()
    private let disposeBag = DisposeBag()
    
    func testObservableRequest() {
        let expectation = self.expectation(description: #function)
        let request = createRequest()
        request.asObservable(in: requestQueue).subscribe(onNext: { response in
            self.assert(request: request, response: response)
            expectation.fulfill()
        }, onError: { error in
            XCTFail("Invalid response")
        }).addDisposableTo(disposeBag)
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testObservableResponse() {
        let expectation = self.expectation(description: #function)
        let request = createRequest()
        requestQueue.add(request)
        TestGetResponse.asObservable(in: requestQueue).subscribe(onNext: { response in
            self.assert(request: request, response: response)
            expectation.fulfill()
        }, onError: { error in
            XCTFail("Invalid response")
        }).addDisposableTo(disposeBag)
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    private func createRequest() -> TestGetRequest {
        return TestGetRequest(parameters: TestGetQueryString(stringParam: "string",
                                                             chineseParam: "中文",
                                                             intParam: 1,
                                                             optionalParam: nil))
    }
    
    private func assert(request: TestGetRequest, response: TestGetResponse) {
        XCTAssert(response.stringParam == request.parameters.stringParam)
        XCTAssert(response.chineseParam == request.parameters.chineseParam)
        XCTAssert(response.intParam == request.parameters.intParam)
        XCTAssert(response.optionalParam == request.parameters.optionalParam)
    }
}
