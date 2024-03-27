//
//  AnimationDevicesSliderCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

import SwiftUI
import Combine

class AnimationDevicesSliderCell: UITableViewCell {
    private var hostingController: UIHostingController<AnimationDevicesSlider>?
    
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let swiftUIView = AnimationDevicesSlider()
        let hostingController = UIHostingController(rootView: swiftUIView)
        let size = hostingController.sizeThatFits(in: UIView.layoutFittingCompressedSize)
        hostingController.view.frame = CGRect(origin: .zero, size: size)
        self.hostingController = hostingController
        
        contentView.addSubview(hostingController.view)
        hostingController.view.topToSuperview()
        hostingController.view.leftToSuperview(offset: 1)
        hostingController.view.rightToSuperview(offset: -1)
        hostingController.view.bottomToSuperview()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct AnimationDevicesSlider: View {
    @State private var icons: [AnimationIcon] = [
        .init(image: "phone-icon"),
        .init(image: "gamepad-icon"),
        .init(image: "mouse-icon"),
        .init(image: "camera-icon"),
        .init(image: "earphones-icon"),
        .init(image: "keyboard-icon"),
        .init(image: "speaker-icon")
    ]
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 2, on: .main, in: .common)
    @State private var cancellable: Cancellable?
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        HStack(spacing: isiPad ? 15 : 9) {
            ForEach(icons) { icon in
                Image(uiImage: UIImage(named: icon.image) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(icon.isActive ? Color.white : Color(uiColor: UIColor.customDarkBlue))
                    .padding(isiPad ? 13 : 8)
                    .background {
                        RoundedRectangle(cornerRadius: isiPad ? 13 : 8, style: .continuous)
                            .fill(icon.isActive ? Color(uiColor: UIColor.customDarkBlue) : Color(uiColor: UIColor.customCellBackground))
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: isiPad ? 13 : 8, style: .continuous)
                            .strokeBorder(Color(uiColor: UIColor.customDarkBlue), lineWidth: isiPad ? 1.0 : 0.6)
                    }
            }
        }
        .onAppear {
            let randomIndex = Int.random(in: 0..<icons.count)
            icons[randomIndex].isActive = true
            
            cancellable = timer.autoconnect().sink(receiveValue: { _ in
                var newIndex: Int
                repeat {
                    newIndex = Int.random(in: 0..<icons.count)
                } while icons[newIndex].isActive == true && icons.contains(where: { $0.isActive == false })
                
                for i in 0..<icons.count {
                    icons[i].isActive = false
                }
                
                withAnimation {
                    icons[newIndex].isActive = true
                }
            })
        }
        .onDisappear() {
            cancellable?.cancel()
        }
    }
}

struct AnimationIcon: Identifiable {
    let id: UUID = .init()
    let image: String
    var isActive: Bool = false
}

#Preview {
    AnimationDevicesSlider()
}
