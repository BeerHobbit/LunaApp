struct AlertState {
    let message: String
    let retryAction: (() -> Void)?
    let cancelAction: (() -> Void)?
}
