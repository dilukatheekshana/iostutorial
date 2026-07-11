import SwiftUI

struct PrimaryButton: View
{

    let title: String
    let action: () -> Void

    var body: some View
    {
        Button(action: action)
        {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
    
}

#Preview
{
    PrimaryButton(title: "Start Quiz")
    {}
    .padding()
}
