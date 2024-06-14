//
//  DetailedNewsView.swift
//  Coingate
//
//  Created by Victor on 21/11/2023.
//

import SwiftUI

struct DetailedNewsView: View {
    
    let news: NewsModel
    @EnvironmentObject var viewModel: NewsViewModel
    @State private var scrollPosition: CGPoint = .zero
    @State private var maxScrollY: CGFloat = 0
    @State private var scrollToTop: Int = 0
    @State private var top: Int =  1
    @State var scrollToIndex: Int = 0

    
    var body: some View {
            ZStack(alignment: .bottom) {
                GeometryReader { outerGeometry in
                    ScrollView {
                        ScrollViewReader { proxy in
                            VStack(alignment: .leading, spacing: 40) {
                                topSection
                                imageSection
                                contentSection
                            }
                                .fontDesign(.rounded)
                                .padding(.bottom, 88)
                                .padding(.horizontal, 16)
                                .background(GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                                })
                                .background(GeometryReader { innerGeometry in
                                    Color.clear
                                        .onAppear {
                                            // Use the total height of the scroll view content as the maximum scroll value
                                            self.maxScrollY = innerGeometry.size.height - outerGeometry.size.height
                                        }
                                })
                                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                                    self.scrollPosition = value
                                    
                                    let progressCount = abs(scrollPosition.y / maxScrollY) * 100
                                    
                                    if progressCount < 10 {
                                        self.scrollToIndex = 0
                                    }
                                }
                                .onChange(of: scrollToIndex) { value in
                                    withAnimation {
                                        proxy.scrollTo(value, anchor: nil)
                                    }
                                    
                                }

                        }
                    }
                    .coordinateSpace(name: "scroll")
                }
                
            progressBar
            }
            
    }
    
    private func hapticSound() {
        let progressCount = abs(scrollPosition.y / maxScrollY) * 100
        if progressCount == 100 {
            HapticsManager.instance.impact(style: .soft)
        }
    }
}

#Preview {
    DetailedNewsView(news: dev.news)
        .environmentObject(dev.newsViewModel)
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

extension DetailedNewsView {
    private var topSection: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text(news.title ?? "n/a")
                .id(top)
                .font(.largeTitle)
                .foregroundStyle(.gray900)
                .fontWeight(.bold)
                
            
            HStack(alignment: .center, spacing: 8, content: {
                Text(news.pubDate?.asFormattedDate().uppercased() ?? "n/a")
                    .font(.callout)
                    
                Circle()
                    .frame(width: 7, height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.gray400)
                
                Text(news.sourceID?.uppercased() ?? "n/a")
                    .font(.callout)
            })
            .foregroundStyle(.gray600)
        })

    }
    
    private var imageSection: some View {
        HStack {
            Spacer()
            NewsImageView(news: news)
                .frame(width: 320, height: 320, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            .rotationEffect(Angle(degrees: -3.27))
            Spacer()
        }
    }
    
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(news.content ?? "")
                .font(.body)
                .lineSpacing(8)
            .foregroundStyle(.gray600)
            
            
            HStack(spacing: 8) {
                ForEach(news.keywords?.prefix(3) ?? [], id: \.self) { word in
                    Text(word)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray500)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(.gray100)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        
                }
            }
        }
    }
    
    private var progressBar: some View {
        
        let progressCount = abs(scrollPosition.y / maxScrollY) * 100
        
        return Button {
           scrollToTop = top
        } label: {
            ZStack(alignment: .leading) {
                
                if progressCount > 99 {
                    Image("arrow-up")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.gray500)
                        .frame(width: 24, height: 24, alignment: .center)
                        .onTapGesture {
                            HapticsManager.instance.impact(style: .soft)
                            scrollToIndex = 1
                        }
                }
                    
                if progressCount < 99 {
                    HStack(spacing: 4) {
//                        Text("\(progressCount > 100 ? 100 : progressCount, specifier: "%.0f")%")
//                            .font(.callout)
//                            .frame(width: 50)
                            //.contentTransition(.numericText(value: 500))
                    
                        RoundedRectangle(cornerRadius: 32)
                            .foregroundStyle(.gray100)
                            .frame(width: progressCount > 0.7 ? 100 : 0, height: 8, alignment: .leading)
                            
                            .overlay(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 32)
                                    .frame(width: progressCount > 100 ? 100 : progressCount, height: 8, alignment: .leading)
                            }
                            .padding(.trailing, 6)
                        
                    }
                    .padding(.horizontal, 8)
                }
                    
            }
            
        }
        .padding(16)
        .background(.white000)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 32)
                .stroke(lineWidth: 0.3)
                .foregroundStyle(.gray200)
                //.background(.thinMaterial)
        })
        .shadow(color: Color(red: 0.09, green: 0.15, blue: 0.29).opacity(0.08).opacity(0.2), radius: 2, x: 0, y: 4)

        .shadow(color: Color(red: 0.09, green: 0.15, blue: 0.29).opacity(0.12), radius: 2, x: 0, y: 2)
        .buttonStyle(BouncyButton())
        .buttonStyle(.plain)

        .opacity(scrollPosition.y < 0 ? 0.75 : scrollPosition.y == 100 ? 1 : 0)
        .padding(.bottom)
        .blur(radius: progressCount > 0.7 ? 0 : 3)
        .animation(.spring(response: 0.3, dampingFraction: 0.75, blendDuration: 1), value: scrollPosition)
        .onAppear {
            hapticSound()
        }

    }
}

