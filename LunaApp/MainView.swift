import SwiftUI

struct MainView: View {
    
    @State private var messageText = ""
    @State private var messages: [String] = [
        "Hello!",
        "Hi!",
        "How are you?",
        "I'm ok!",
        "Nice!",
        "And how are you?"
    ]
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.lunaViewBackground)
                .resizable()
                .frame(height: 170)
                .border(Color.LunaColors.violet, width: 3)
                .background(
                    Color.LunaColors.gray.shadow(
                        .drop(
                            color: .black.opacity(0.35),
                            radius: 0,
                            x: 0,
                            y: 6
                        )
                    )
                )
                .zIndex(1)
                .onTapGesture {
                    isFocused = false
                }
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 12)
                    ForEach(messages, id: \.self) { message in
                        Text(message)
                            .font(AppFont.regular)
                            .foregroundStyle(Color.LunaColors.white)
                            .padding()
                            .background(Color.LunaColors.violet)
                        
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .onTapGesture {
                isFocused = false
            }
            HStack(alignment: .center, spacing: 8) {
                TextField("Напиши мне...", text: $messageText, axis: .vertical)
                    .font(AppFont.regular)
                    .lineLimit(4)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .foregroundStyle(Color.LunaColors.black)
                    .focused($isFocused)
                VStack {
                    Spacer(minLength: 0)
                    Button(action: {
                        
                    }) {
                        Image(.enter)
                            .tint(Color.LunaColors.gray)
                    }
                    .frame(width: 60, height: 36)
                    .background(
                        Color.LunaColors.white
                            .shadow(
                                .inner(
                                    color: .black.opacity(0.35),
                                    radius: 0,
                                    x: -4,
                                    y: -4
                                )
                            )
                    )
                }
            }
            .onTapGesture {
                isFocused = true
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(4)
            .background(
                Color.LunaColors.lightGray
                    .shadow(
                        .drop(
                            color: .black.opacity(0.35),
                            radius: 0,
                            x: 0,
                            y: -6
                        )
                    )
            )
        }
        .padding(
            EdgeInsets(
                top: 8,
                leading: 16,
                bottom: 8,
                trailing: 16
            )
        )
        .background(
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
    
}

struct MessageView: View {
    
    let message: Message
    
    var body: some View {
        
    }
}

#Preview {
    MainView()
}
