import UIKit
import AVKit
import AVFoundation
import SnapKit

enum PremiumMainControllerStyle_HSCF {
    case mainProduct,unlockContentProduct,unlockFuncProduct,unlockOther
}

class HSCFPremiumMainController: UIViewController {
    
    private weak var player: HSCFPlayer!
    private var view0 = HSCFReusableView()
    private var view1 = HSCFReusableView()
    private var viewTransaction = HSCFTransactionView()
    
    @IBOutlet private weak var freeform: UIView!
    @IBOutlet private weak var videoElement: UIView!
    @IBOutlet private weak var restoreBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    var subscribed: (() -> Void)?
    
    public var productBuy : PremiumMainControllerStyle_HSCF = .mainProduct
    
    private var intScreenStatus = 0
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        view.backgroundColor = .black
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        initVideoElement_HSCF()
        startMaked()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        if !HSCFNetworkStatusMonitor.shared.isNetworkAvailable {
            showMess_HSCF()
        }
    }
    
    deinit {
        func somDogAndwsdhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        startstop_this_deinitPlayer_HSCF()
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
    }
    
    private func initVideoElement_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
            BGPlayer()
        }
    }
    
    func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
        var a = (game as! Decimal) + 300 + 30
        a += 95
        return treg == true || a == 30
    }
    
    //MARK: System events
    
    private func startstop_this_deinitPlayer_HSCF() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        if let player {
          self.player.volume = 0
          self.player.url = nil
          self.player.didMove(toParent: nil)
        }
        player = nil
      }

    // MARK: - Setup Video Player

    private func BGPlayer() {
        var pathUrl = Bundle.main.url(forResource: ConfigurationMediaSub_hscf.nameFileVideoForPhone, withExtension: ConfigurationMediaSub_hscf.videoFileType)
        if UIDevice.current.userInterfaceIdiom == .pad {
            pathUrl = Bundle.main.url(forResource: ConfigurationMediaSub_hscf.nameFileVideoForPad, withExtension: ConfigurationMediaSub_hscf.videoFileType)
        }else{
            pathUrl = Bundle.main.url(forResource: ConfigurationMediaSub_hscf.nameFileVideoForPhone, withExtension: ConfigurationMediaSub_hscf.videoFileType)
        }

       let player = HSCFPlayer()
        //player.muted = true
        player.playerDelegate = self
        player.playbackDelegate = self
        player.view.frame = self.view.bounds

        addChild(player)
        view.addSubview(player.view)
        player.didMove(toParent: self)
        player.url = pathUrl
        if UIDevice.current.userInterfaceIdiom == .pad {
            player.playerView.playerFillMode = .resizeAspectFill
        }else{
            player.playerView.playerFillMode = .resize
        }
        player.playbackLoops = true
        view.sendSubviewToBack(player.view)
        self.player = player
    }
    
    private func loopVideoMB(videoPlayer:AVPlayer){
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            videoPlayer.seek(to: .zero)
            videoPlayer.play()
        }
    }
    
    // MARK: - Make UI/UX
    
    private func startMaked() {
        setRestoreBtn()
        if productBuy == .mainProduct {
            setReusable(config: .first, isHide: false)
            setReusable(config: .second, isHide: true)
            setTransaction(isHide: true)
        } else {
            setTransaction(isHide: false)
            self.showRestore()
        }
    }
    
    //reusable setup
    
    private func generateContentForView(config: configView_HSCF) -> [ReusableContentCell_HSCF] {
        var contentForCV : [ReusableContentCell_HSCF] = []
        switch config {
        case .first:
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            return contentForCV
        case .second:
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell_HSCF(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            return contentForCV
        case .transaction: return contentForCV
        }
    }
    
    private func setReusable(config : configView_HSCF, isHide : Bool){
        var currentView : HSCFReusableView? = nil
        var viewModel : ReusableViewModel_HSCF? = nil
        switch config {
        case .first:
            viewModel =  ReusableViewModel_HSCF(title: localizedString(forKey: "TextTitle1ID").uppercased(), items: self.generateContentForView(config: config))
            currentView = self.view0
        case .second:
            viewModel =  ReusableViewModel_HSCF(title: localizedString(forKey: "TextTitle2ID").uppercased(), items: self.generateContentForView(config: config))
            currentView = self.view1
        case .transaction:
            currentView = nil
        }
        guard let i = currentView else { return }
        i.protocolElement = self
        i.viewModel = viewModel
        i.configView = config
        freeform.addSubview(i)
        freeform.bringSubviewToFront(i)
        
        i.snp.makeConstraints { make in
            make.height.equalTo(338)
            make.width.equalTo(freeform).multipliedBy(1)
            make.centerX.equalTo(freeform).multipliedBy(1)
            make.bottom.equalTo(freeform).offset(0)
        }
        i.isHidden = isHide
    }
    //transaction setup
    
    private func setTransaction( isHide : Bool) {
        self.viewTransaction.inapp.productBuy = self.productBuy
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewTransaction.setLocalization_TOC_HSCF()
        }
        freeform.addSubview(self.viewTransaction)
        freeform.bringSubviewToFront(self.viewTransaction)
        self.viewTransaction.inapp.productBuy = self.productBuy
        self.viewTransaction.snp.makeConstraints { make in
            //            make.height.equalTo(338)
            make.width.equalTo(freeform).multipliedBy(1)
            make.centerX.equalTo(freeform).multipliedBy(1)
            make.bottom.equalTo(freeform).offset(0)
        }
        self.viewTransaction.isHidden = isHide
        self.viewTransaction.delegate = self
    }
    
    // restore button setup
    
    private func setRestoreBtn(){
        self.restoreBtn.isHidden = true
        self.restoreBtn.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 12 : 22)
        self.restoreBtn.setTitle(localizedString(forKey: "restore"), for: .normal)
        self.restoreBtn.titleLabel?.setShadow_S32HP()
        self.restoreBtn.tintColor = .white
        self.restoreBtn.setTitleColor(.white, for: .normal)
    }
    
    private func openApp() {
        dismiss(animated: false)
        subscribed?()
//        let vc = InitialViewController()
//        UIApplication.shared.setRootVC_HSCF(vc)
//        UIApplication.shared.notificationFeedbackGenerator_HSCF(type: .success)
        startstop_this_deinitPlayer_HSCF()
    }
    
    private func showRestore(){
        self.restoreBtn.isHidden = false
        if productBuy != .mainProduct {
            self.closeBtn.isHidden = false
        }
    }
    
    @IBAction func restoreAction_HSCF(_ sender: UIButton) {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.viewTransaction.t_func_restoreAction_HSCF()
    }
    
    @IBAction func closeController(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

typealias hs_prem_main_controlelr = HSCFPremiumMainController

extension hs_prem_main_controlelr : ReusableViewEvent_HSCF, NetworkStatusMonitorDelegate_HSCF, TransactionViewEvents_HSCF {
    func nextStep(config: configView_HSCF) {
        switch config {
        case .first:
            self.view0.fadeOut_hpcs()
            self.view1.fadeIn_S32HP()
            UIApplication.shared.impactFeedbackGenerator_HSCF(type: .medium)
        case .second:
            self.view1.fadeOut_hpcs()
            self.viewTransaction.fadeIn_S32HP()
            self.showRestore()
            //            self.viewTransaction.title.restartpageControl()
            UIApplication.shared.impactFeedbackGenerator_HSCF(type: .medium)
        case .transaction: break
        }
    }

    func showMess_HSCF() {
        func_33_transactionTreatment_TOC_HSCF(title: NSLocalizedString( "ConnectivityTitle", comment: ""), message: NSLocalizedString("ConnectivityDescription", comment: ""))
    }
    
    func userSubscribed() {
        self.openApp()
    }
    
    func func_33_transactionTreatment_TOC_HSCF(title: String, message: String) {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        UIApplication.shared.notificationFeedbackGenerator_HSCF(type: .warning)
    }
    
    func transactionFailed() {
        print(#function)
        UIApplication.shared.notificationFeedbackGenerator_HSCF(type: .error)
    }
    
    func privacyOpen() {
        Configurations_HSCF.policyLink.openURL_S32HP()
    }
    
    func termsOpen() {
        Configurations_HSCF.termsLink.openURL_S32HP()
    }
}

extension hs_prem_main_controlelr: PlayerDelegate_HSCF, PlayerPlaybackDelegate_HSCF {
    func playerReady(_ player: HSCFPlayer) { }

    func playerPlaybackStateDidChange(_ player: HSCFPlayer) { }

    func playerBufferingStateDidChange(_ player: HSCFPlayer) { }

    func playerBufferTimeDidChange(_ bufferTime: Double) { }

    func player(_ player: HSCFPlayer, didFailWithError error: Error?) { }

    func playerCurrentTimeDidChange(_ player: HSCFPlayer) { }

    func playerPlaybackWillStartFromBeginning(_ player: HSCFPlayer) { }

    func playerPlaybackDidEnd(_ player: HSCFPlayer) { }

    func playerPlaybackWillLoop(_ player: HSCFPlayer) { }

    func playerPlaybackDidLoop(_ player: HSCFPlayer) { }
}

