import SwiftUI
internal import Combine

struct LightItUpView: View
{

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

    var body: some View
    {

        ZStack
        {
            
            Color.black
                .ignoresSafeArea()
            
            VStack
            {
                
                if !viewModel.gameOver
                {
                    
                    Text("Light It Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                        .padding(.top)

                    HStack
                    {
                        
                        VStack(alignment: .leading)
                        {
                            Text("Score")
                                .foregroundStyle(.gray)
                            
                            Text("\(viewModel.score)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing)
                        {
                            Text("Time")
                                .foregroundStyle(.gray)
                            
                            Text("\(viewModel.timeRemaining)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
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

                }
                else
                {

                    Spacer()

                    VStack(spacing: 25)
                    {
                        Text("Game Over!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                        
                        VStack(spacing: 10)
                        {
                            Text("Final Score: \(viewModel.score)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                            
                            Text("High Score: \(viewModel.highScore)")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }

                        Button("Play Again")
                        {
                            viewModel.restartGame()
                        }
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        
                        ShareLink(
                            item: "💡 I scored \(viewModel.score) points in Light It Up on PlayHub!"
                        ) {

                            Label("Share Score", systemImage: "square.and.arrow.up")
                                .frame(width: 180)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(14)

                        }
                    }

                    Spacer()
                }
            }
        }
        .onAppear
        {
            viewModel.setupCards()
            viewModel.lightRandomCards()
        }
        .onReceive(gameTimer)
        {
            _ in
            viewModel.processGameTimer()
        }
        .onReceive(lightTimer)
        {
            _ in
            viewModel.processLightTimer()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview
{
    LightItUpView()
}
