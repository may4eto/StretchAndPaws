//
//  DetailView.swift
//  Stretch+Paws
//
//  Created by Maya Mircheva on 14/06/2022.
//

import SwiftUI

struct DetailView: View {
    let pose: Pose
    @State private var timerOpen = false
    var body: some View {
        ZStack {
            Color("Secondary").ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack (spacing: 20) {
                    Image(pose.icon)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text(pose.name)
                        .fontWeight(.bold)
                        .font(.system(size: 36))
                        .foregroundColor(Color("Highlight"))
                        .multilineTextAlignment(.center)
                    Text(pose.asana)
                        .font(.system(size: 22))
                        .italic()
                        .fontWeight(.medium)
                    
                    VStack (alignment: .leading, spacing: 20) {
                        Text(pose.description)
                        Text("How to:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
                        ForEach(pose.steps, id: \.self) {step in
                            Text(step)
                        }
                        Text("Top tip:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
                        Text(pose.topTip)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
                
            }
            TimerPanelView(timerOpen: $timerOpen)
        }
        .onTapGesture {
            timerOpen = false
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pose: Pose(
            name: "Downward-Facing Dog",
            asana: "Adho Mukha Shvanasana",
            icon: "Cat-1",
            description:
            "Did someone say dog? Can't we call this a downward-facing cat instead? It's OK – this is a friendly dog, it's not interested in chasing cats. In fact, Downward-Facing Dog is the lynchpin of a yoga asana practice: if you're going to befriend with any of these poses, make sure it's this canine classic.",
            steps: ["From a kneeling position, place your hands shoulder-distance apart and spread your fingers.", "Tuck your toes and lift your hips up towards the ceiling so you create an inverted V shape.", "Balance the weight between hands and feet and think about tilting your tailbone up towards the ceiling.","Send your gaze towards your feet and breath!"],
            topTip: "Bend your knees in order to create more length through the spine." ))
    }
}

struct TimerPanelView: View {
    @StateObject var yogaTimer = YogaTimer()
    @Binding var timerOpen: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack {
                timerOpen ? AnyView(TimerOpenView(yogaTimer: yogaTimer)) : AnyView(TimerClosedView())
            }
            .foregroundColor(Color("Secondary"))
            .frame(maxWidth: .infinity, maxHeight: timerOpen ? 400 : 80)
            .background(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 20).fill(Color("Highlight")))
            
        }
        .ignoresSafeArea()
        .onTapGesture {
            timerOpen.toggle()
        }
    }
}


struct TimerOpenView: View {
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View {
        VStack {
            Text(yogaTimer.setTitleText())
                .font(.title3)
                .fontWeight(.medium)
            Spacer()
            Text(yogaTimer.setDescriptionText())
                .multilineTextAlignment(.center)
            Spacer()
            if !yogaTimer.timerEnded {
                CountdownView(yogaTimer: yogaTimer)
                Spacer()
            }
            if yogaTimer.timerActive {
                TimerPauseButtonView(yogaTimer: yogaTimer)
            } else {
                TimerStartButtonView(yogaTimer: yogaTimer)
            }
        }
        .padding(30)
    }
}

struct TimerClosedView: View {
    var body: some View {
        Text("Try it out")
            .font(.title3)
            .fontWeight(.medium)
            .padding(20)
        Spacer()
    }
}

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
 

struct CountdownView: View {
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View {
        Text(yogaTimer.timerDuration < 10 ? "00:0\(yogaTimer.timerDuration)" : "00:\(yogaTimer.timerDuration)")
            .font(.system(size: 96))
    }
}

struct TimerPauseButtonView: View {
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View {
        Button {yogaTimer.pauseTimer()} label: {Text("Pause the timer").padding(70)}
            .frame(width: 300, height: 50)
            .background(Color("Highlight"))
            .overlay(
                RoundedRectangle(cornerRadius:25)
                    .stroke(Color("Secondary"), lineWidth: 3)
            )
            .foregroundColor(Color("Secondary"))
            .cornerRadius(25)
    }
}

struct TimerStartButtonView: View {
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View {
        Button {yogaTimer.startTimer()} label: {Text(yogaTimer.timerPaused || yogaTimer.timerEnded ? "Restart the timer" : "Start the timer").padding(70)}
            .frame(width: 300, height: 50)
            .background(Color("Secondary"))
            .foregroundColor(Color("Primary"))
            .cornerRadius(25)
    }
}
