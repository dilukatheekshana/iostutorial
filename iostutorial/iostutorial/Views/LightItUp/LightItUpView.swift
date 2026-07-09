import SwiftUI
internal import Combine

struct LightItUpView: View {

    @StateObject private var viewModel = LightItUpViewModel()

    let gameTimer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()

    let lightTimer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()

    var body: some View {

        ZStack {
            
            // MARK: - Background
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                if !viewModel.gameOver {
                    
                    Text("Light It Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top)
                    
                    // Score & Time Row (Styled like QuizRush)
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text("Score")
                                .foregroundStyle(.gray)
                            
                            Text("\(viewModel.score)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.yellow)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Time")
                                .foregroundStyle(.gray)
                            
                            Text("\(viewModel.timeRemaining)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.orange)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    Spacer()

                    Text("Level \(viewModel.currentLevel)")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.bottom)

                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible()),
                            count: viewModel.gridColumns
                        ),
                        spacing: 15
                    ) {

                        ForEach(viewModel.cards.indices, id: \.self) { index in

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    viewModel.cards[index].isLit
                                    ? viewModel.levelColor
                                    : Color.gray.opacity(0.3)
                                )
                                .frame(height: 100)
                                .scaleEffect(
                                    viewModel.cards[index].isLit ? 1.1 : 1.0
                                )
                                .animation(
                                    .easeInOut,
                                    value: viewModel.cards[index].isLit
                                )
                                .onTapGesture {
                                    viewModel.cardTapped(at: index)
                                }
                        }
                    }
                    .padding()
                    Spacer()

                } else {

                    Spacer()

                    VStack(spacing: 25) {

                        Text("Game Over!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        VStack(spacing: 10) {
                            Text("Final Score: \(viewModel.score)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.yellow)
                            
                            Text("High Score: \(viewModel.highScore)")
                                .font(.title2)
                                .foregroundStyle(.orange)
                        }

                        Button("Play Again") {
                            viewModel.restartGame()
                        }
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        
                        ShareLink(
                            item: "💡 I scored \(viewModel.score) points in Light It Up on PlayHub!"
                        ) {

                            Label("Share Score", systemImage: "square.and.arrow.up")
                                .frame(width: 180)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(14)

                        }
                    }

                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.setupCards()
            viewModel.lightRandomCards()
        }
        .onReceive(gameTimer) { _ in
            viewModel.processGameTimer()
        }
        .onReceive(lightTimer) { _ in
            viewModel.processLightTimer()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    LightItUpView()
}
