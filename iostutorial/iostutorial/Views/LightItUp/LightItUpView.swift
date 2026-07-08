import SwiftUI
internal import Combine

struct GameCard: Identifiable {
    let id = UUID()
    var isLit = false
}

struct LightItUpView: View {

    @State private var cards: [GameCard] = []

    @State private var score = 0
    @State private var timeRemaining = 60
    @State private var gameOver = false

    @State private var currentLevel = 1

    @AppStorage("LightItUpHighScore")
    private var highScore = 0

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
                
                if !gameOver {
                    
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

                    Text("Level \(currentLevel)")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.bottom)

                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible()),
                            count: gridColumns
                        ),
                        spacing: 15
                    ) {

                        ForEach(cards.indices, id: \.self) { index in

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    cards[index].isLit
                                    ? levelColor
                                    : Color.gray.opacity(0.3)
                                )
                                .frame(height: 100)
                                .scaleEffect(
                                    cards[index].isLit ? 1.1 : 1.0
                                )
                                .animation(
                                    .easeInOut,
                                    value: cards[index].isLit
                                )
                                .onTapGesture {

                                    if cards[index].isLit {

                                        score += 1

                                        cards[index].isLit = false

                                    } else {

                                        score = max(0, score - 1)
                                    }
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
                            Text("Final Score: \(score)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.yellow)
                            
                            Text("High Score: \(highScore)")
                                .font(.title2)
                                .foregroundStyle(.orange)
                        }

                        Button("Play Again") {
                            restartGame()
                        }
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                    }

                    Spacer()
                }
            }
        }
        .onAppear {

            setupCards()
            lightRandomCards()
        }
        .onReceive(gameTimer) { _ in

            if !gameOver {

                timeRemaining -= 1

                updateLevel()

                if timeRemaining <= 0 {

                    gameOver = true
                
                    //implement game session service
                    GameSessionService.shared.addSession(
                        GameSession(
                            mode: .lightItUp,
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
        .onReceive(lightTimer) { _ in

            if !gameOver {

                lightRandomCards()
            }
        }
    }

    // MARK: - Level Configuration

    func updateLevel() {

        let elapsed = 60 - timeRemaining

        let newLevel: Int

        if elapsed < 15 {

            newLevel = 1

        } else if elapsed < 30 {

            newLevel = 2

        } else if elapsed < 45 {

            newLevel = 3

        } else {

            newLevel = 4
        }

        if newLevel != currentLevel {

            currentLevel = newLevel

            setupCards()
        }
    }

    // MARK: - Setup Cards

    func setupCards() {

        switch currentLevel {

        case 1:
            cards = Array(repeating: GameCard(), count: 3)

        case 2:
            cards = Array(repeating: GameCard(), count: 4)

        case 3:
            cards = Array(repeating: GameCard(), count: 6)

        default:
            cards = Array(repeating: GameCard(), count: 9)
        }
    }

    // MARK: - Light Cards

    func lightRandomCards() {

        for index in cards.indices {

            cards[index].isLit = false
        }

        if cards.isEmpty { return }

        if currentLevel == 4 {

            let first = Int.random(in: 0..<cards.count)

            var second = Int.random(in: 0..<cards.count)

            while second == first {

                second = Int.random(in: 0..<cards.count)
            }

            cards[first].isLit = true
            cards[second].isLit = true

        } else {

            let random = Int.random(in: 0..<cards.count)

            cards[random].isLit = true
        }
    }

    // MARK: - Grid Layout

    var gridColumns: Int {

        switch currentLevel {

        case 1:
            return 3

        case 2:
            return 4

        case 3:
            return 3

        default:
            return 3
        }
    }

    // MARK: - Level Colors

    var levelColor: Color {

        switch currentLevel {

        case 1:
            return .yellow

        case 2:
            return .green

        case 3:
            return .orange

        default:
            return .red
        }
    }

    // MARK: - Restart

    func restartGame() {

        score = 0
        timeRemaining = 60
        gameOver = false
        currentLevel = 1

        setupCards()
        lightRandomCards()
    }
}

#Preview {
    LightItUpView()
}
