struct ChatRequest: APIRequest {
    typealias DTO = [Message]
    
    static let method: HTTPMethod = .post
    let path: String = "chat"
    let headers: [String : String]? = ["Content-Type": "application/json"]
    let bodyDTO: [Message]?
    
    init(bodyDTO: [Message]?) {
        self.bodyDTO = bodyDTO
    }
}
