import SwiftUI
internal import Combine

struct TapFrenzyView: View
{
    
    @StateObject private var viewModel = TapFrenzyViewModel()
    
    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()
    
    let moveTimer = Timer.publish(
        every: 2,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View
    {
        
        GeometryReader
        {
            geometry in
            
            ZStack
            {
                Color.black
                    .ignoresSafeArea()
                
                if !viewModel.gameOver
                {
                    VStack
                    {
                        Text("Tap Frenzy")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                            .padding(.top, 40)

                        HStack
                        {
                            VStack(alignment: .leading)
                            {
                                Text("Score")
                                    .foregroundStyle(.gray)
                                
                                Text("\(viewModel.score)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
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
                        
                    }

                    Button(action:
                    {
                        viewModel.tapButton()
                    })
                    {
                        Text("TAP")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(
                                width: viewModel.buttonSize,
                                height: viewModel.buttonSize
                            )
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .position(
                        x: viewModel.buttonX,
                        y: viewModel.buttonY
                    )
                    .onReceive(moveTimer) { _ in
                        viewModel.moveTarget(geometry: geometry)
                    }
                    
                }
                else
                {
                    
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
                                .foregroundStyle(.blue)
                            
                            Text("High Score: \(viewModel.highScore)")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        
                        Button("Play Again") {
                            viewModel.restartGame(geometry: geometry)
                        }
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        
                        ShareLink(
                            item: "🎮 I scored \(viewModel.score) points in Tap Frenzy on PlayHub! Can you beat my score?"
                        )
                        {
                            Label("Share Score", systemImage: "square.and.arrow.up")
                                .frame(width: 180)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(14)
                        }
                    }
                }
            }
            .onAppear
            {
                viewModel.setInitialPosition(geometry: geometry)
            }
            .onReceive(timer)
            {
                _ in
                viewModel.processTimerTick()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview
{
    TapFrenzyView()
}
