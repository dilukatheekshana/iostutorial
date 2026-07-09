import SwiftUI
internal import Combine

struct TapFrenzyView: View {
    
    @StateObject private var viewModel = TapFrenzyViewModel()
    
    // Main Countdown Timer
    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()
    
    // Moving Target Timer
    let moveTimer = Timer.publish(
        every: 2,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                // MARK: - Background
                Color.black
                    .ignoresSafeArea()
                
                if !viewModel.gameOver {
                    
                    VStack {
                        
                        // Title
                        Text("Tap Frenzy")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.top, 40)
                        
                        // Score + Timer Row (Styled like QuizRush)
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
                        
                    }
                    
                    // TAP BUTTON
                    Button(action: {
                        viewModel.tapButton()
                    }) {
                        Text("TAP")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(
                                width: viewModel.buttonSize,
                                height: viewModel.buttonSize
                            )
                            .background(Color.purple)
                            .clipShape(Circle())
                    }
                    .position(
                        x: viewModel.buttonX,
                        y: viewModel.buttonY
                    )
                    .onReceive(moveTimer) { _ in
                        viewModel.moveTarget(geometry: geometry)
                    }
                    
                } else {
                    
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
                            viewModel.restartGame(geometry: geometry)
                        }
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        
                        ShareLink(
                            item: "🎮 I scored \(viewModel.score) points in Tap Frenzy on PlayHub! Can you beat my score?"
                        ) {
                            Label("Share Score", systemImage: "square.and.arrow.up")
                                .frame(width: 180)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                        }
                    }
                }
            }
            .onAppear {
                // Initial button position
                viewModel.setInitialPosition(geometry: geometry)
            }
            .onReceive(timer) { _ in
                viewModel.processTimerTick()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    TapFrenzyView()
}
