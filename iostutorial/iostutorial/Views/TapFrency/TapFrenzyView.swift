import SwiftUI
internal import Combine

struct TapFrenzyView: View {

    // MARK: - Game State

    @State private var score = 0
    @State private var highScore = 0
    @State private var timeRemaining = 10
    @State private var gameOver = false

    // Moving Target Position
    @State private var buttonX: CGFloat = 200
    @State private var buttonY: CGFloat = 500

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

                if !gameOver {

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
                                
                                Text("\(score)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.yellow)
                            }

                            Spacer()

                            VStack(alignment: .trailing) {
                                Text("Time")
                                    .foregroundStyle(.gray)
                                
                                Text("\(timeRemaining)")
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
                        score += 1
                    }) {

                        Text("TAP")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(
                                width: buttonSize,
                                height: buttonSize
                            )
                            .background(Color.purple)
                            .clipShape(Circle())
                    }
                    .position(
                        x: buttonX,
                        y: buttonY
                    )
                    .onReceive(moveTimer) { _ in

                        if !gameOver {

                            withAnimation(.easeInOut(duration: 0.5)) {

                                buttonX = CGFloat.random(
                                    in: 80...(geometry.size.width - 80)
                                )

                                buttonY = CGFloat.random(
                                    in: 250...(geometry.size.height - 120)
                                )
                            }
                        }
                    }

                } else {

                    VStack(spacing: 25) {

                        Text("Game Over!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        VStack(spacing: 10) {
                            Text("Final Score: \(score)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.yellow)

                            Text("High Score: \(highScore)")
                                .font(.title2)
                                .foregroundStyle(.orange)
                        }

                        Button("Play Again") {
                            restartGame(geometry: geometry)
                        }
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                    }
                }
            }
            .onAppear {

                // Initial button position
                buttonX = geometry.size.width / 2
                buttonY = geometry.size.height * 0.70
            }
            .onReceive(timer) { _ in

                if !gameOver {

                    if timeRemaining > 0 {

                        timeRemaining -= 1

                    } else {

                        gameOver = true
                        
                        //implement game session service
                         GameSessionService.shared.addSession(
                             GameSession(
                                 mode: .tapFrenzy,
                                 score: score
                             )
                         )
                        
                         print(GameSessionService.shared.loadSessions())

                        if score > highScore {
                            highScore = score
                        }
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
        
    // MARK: - Shrinking Button Challenge

    var buttonSize: CGFloat {

        switch timeRemaining {

        case 8...10:
            return 150

        case 5...7:
            return 120

        case 2...4:
            return 90

        default:
            return 60
        }
    }

    // MARK: - Restart Game

    func restartGame(geometry: GeometryProxy) {

        score = 0
        timeRemaining = 10
        gameOver = false

        buttonX = geometry.size.width / 2
        buttonY = geometry.size.height * 0.70
    }
}


#Preview {
    TapFrenzyView()
}
