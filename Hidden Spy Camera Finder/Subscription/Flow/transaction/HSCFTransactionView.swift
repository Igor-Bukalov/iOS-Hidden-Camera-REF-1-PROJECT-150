//  Created by Alexander N on 14.07.2023
//


import UIKit

protocol TransactionViewEvents_HSCF : AnyObject {
    func userSubscribed()
    func func_33_transactionTreatment_TOC_HSCF(title: String, message: String)
    func transactionFailed()
    func privacyOpen()
    func termsOpen()
}

class HSCFTransactionView: UIView,AnimatedButtonEvent_HSCF,IAPManagerProtocol_HSCF, NetworkStatusMonitorDelegate_HSCF {
    func showMess_HSCF() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        transactionTreatment_TOC_HSCF(title: NSLocalizedString( "ConnectivityTitle", comment: ""), message: NSLocalizedString("ConnectivityDescription", comment: ""))
    }
    
    
    private let xib = "HSCFTransactionView"
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private(set) weak var title: UILabel!
    @IBOutlet private weak var sliderStack: UIStackView!
    @IBOutlet private weak var trialLb: UILabel!
    @IBOutlet private weak var descriptLb: UILabel!
    @IBOutlet private weak var purchaseBtn: HSCFAnimatedButton!
    @IBOutlet private weak var privacyBtn: UIButton!
    @IBOutlet private weak var policyBtn: UIButton!
    @IBOutlet private weak var sliderWight: NSLayoutConstraint!
    @IBOutlet private weak var sliderTop: NSLayoutConstraint!
    @IBOutlet private weak var conteinerWidth: NSLayoutConstraint!
    @IBOutlet private weak var heightView: NSLayoutConstraint!
    //@IBOutlet private weak var trialWight: NSLayoutConstraint!
    @IBOutlet weak var trialView: UIView!
    
    private let currentFont = Configurations_HSCF.getSubFontName_HSCF()
    public let inapp = HSCFIAPManager.shared
    private let locale = NSLocale.current.languageCode
    public weak var delegate : TransactionViewEvents_HSCF?
    private let networkingMonitor = HSCFNetworkStatusMonitor.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Init()
    }
    
    private func Init() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Устройство является iPhone
            if UIScreen.main.nativeBounds.height >= 2436 {
                heightView.constant = 163
            } else {
//                sliderTop.constant = 60
                heightView.constant = 152
            }
        } else {
            conteinerWidth.constant = 400
            heightView.constant = 167
//            sliderTop.constant = 45
        }
        contentView.fixInView_HSCF(self)
        contentView.backgroundColor = .clear
        buildConfigs_TOC_HSCF()
    }
    
    func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
        var a = (game as! Decimal) + 300 + 30
        a += 95
        return treg == true || a == 30
    }
    
    private func buildConfigs_TOC_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        pri_funio_configScreen_TOCHSCF()
        setSlider_TOC_HSCF()
        setConfigLabels_TOC_HSCF()
        setConfigButtons_TOC_HSCF()
        setLocalization_TOC_HSCF()
        configsInApp_TOC_HSCF()
    }
    
    private func setSlider_TOC_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        title.text = (localizedString(forKey: "SliderID1").uppercased())
        var texts: [String] = ["\(localizedString(forKey: "SliderID2"))",
                               "\(localizedString(forKey: "SliderID3"))",
                               "\(localizedString(forKey: "SliderID4"))",
                               ]
        for t in texts {
            sliderStack.addArrangedSubview(HSCFSliderCellView(title: t, subTitle: t.lowercased()))
        }
    }
    
    //MARK: config labels
    
    private func setConfigLabels_TOC_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        //slider
        title.textColor = .white
        title.font = UIFont(name: currentFont, size: 24)
//        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 4
        title.setShadow_S32HP()
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            title.textAlignment = .right
        }
        title.lineBreakMode = .byClipping
        if UIDevice.current.userInterfaceIdiom == .pad {
            title.font = UIFont(name: currentFont, size: 24)
        }
        trialLb.setShadow_S32HP()
        trialLb.font = UIFont(name: currentFont, size: 13)
        trialLb.textColor = .white
        trialLb.textAlignment = .center
        trialLb.numberOfLines = 2
        trialLb.adjustsFontSizeToFitWidth = true
        
        descriptLb.setShadow_S32HP()
        descriptLb.textColor = .white
        descriptLb.textAlignment = .center
        descriptLb.numberOfLines = 0
        descriptLb.font = UIFont.systemFont(ofSize: 15)
        
        privacyBtn.titleLabel?.setShadow_S32HP()
        privacyBtn.titleLabel?.numberOfLines = 2
        privacyBtn.titleLabel?.textAlignment = .center
        
        privacyBtn.setTitleColor(.white, for: .normal)
        privacyBtn.tintColor = .white
        
        policyBtn.titleLabel?.setShadow_S32HP()
        policyBtn.titleLabel?.numberOfLines = 2
        policyBtn.titleLabel?.textAlignment = .center
        policyBtn.setTitleColor(.white, for: .normal)
        policyBtn.tintColor = .white
        privacyBtn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 12)
        policyBtn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 12)
    }
    
    //MARK: config button
    
    private func setConfigButtons_TOC_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.purchaseBtn.delegate = self
        self.purchaseBtn.style = .native
    }
    
    //MARK: config localization
    
    public func setLocalization_TOC_HSCF() {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
//        title.labelTextsForSlider = "\(localizedString(forKey: "SliderID1").uppercased())|n\(localizedString(forKey: "SliderID2").uppercased())|n\(localizedString(forKey: "SliderID3").uppercased()) |n\(localizedString(forKey: "SliderID4").uppercased()) |n\(localizedString(forKey: "SliderID5").uppercased())"
        
        let localizedPrice = inapp.localizedPrice_HSCF()
        descriptLb.text = localizedString(forKey: "iOSAfterID").replacePriceWithNewPrice_HSCF(newPriceString: localizedPrice)
        
        if locale == "en" {
            trialLb.text = "Start 3-days for FREE\n Then \(localizedPrice)/week".uppercased()
        } else {
            trialLb.text = ""
            trialView.isHidden = true
        }
        privacyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        privacyBtn.setAttributedTitle(localizedString(forKey: "TermsID").underLined, for: .normal)
        policyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        policyBtn.setAttributedTitle(localizedString(forKey: "PrivacyID").underLined, for: .normal)
    }
    
    //MARK: screen configs
    
    private func pri_funio_configScreen_TOCHSCF(){
        if UIDevice.current.userInterfaceIdiom == .pad {
            //trialWight.setValue(0.28, forKey: "multiplier")
            //sliderWight.setValue(0.5, forKey: "multiplier")
        } else {
            //trialWight.setValue(0.46, forKey: "multiplier")
            //sliderWight.setValue(0.8, forKey: "multiplier")
        }
    }
    
    //MARK: configs
    
    private func configsInApp_TOC_HSCF(){
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.inapp.transactionsDelegate = self
        self.networkingMonitor.delegate = self
    }
    
    public func t_func_restoreAction_HSCF(){
        inapp.doRestore_HSCF()
    }
    
    //MARK: actions
    
    @IBAction func privacyAction_HSCF(_ sender: UIButton) {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.delegate?.termsOpen()
    }
    
    @IBAction func termsAction_HSCF(_ sender: UIButton) {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.delegate?.privacyOpen()
    }
    
    func onClick_HSCF() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        UIApplication.shared.impactFeedbackGenerator_HSCF(type: .heavy)
        if networkingMonitor.checkInternetConnectivity() {
            inapp.doPurchase_HSCF()
            purchaseBtn.isUserInteractionEnabled = false
        } else {
            showMess_HSCF()
        }
    }
    
    //inapp
    
    func transactionTreatment_TOC_HSCF(title: String, message: String) {
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.func_33_transactionTreatment_TOC_HSCF(title: title, message: message)
    }
    
    func infoAlert_HSCF(title: String, message: String) {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.func_33_transactionTreatment_TOC_HSCF(title: title, message: message)
    }
    
    func goToTheApp_HSCF() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.userSubscribed()
    }
    
    func failed() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.transactionFailed()
    }
}

extension HSCF_String_NA_ONE {
    func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
        var a = (game as! Decimal) + 300 + 30
        a += 95
        return treg == true || a == 30
    }
    func replacePriceWithNewPrice_HSCF(newPriceString: String) -> String {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        var result = self.replacingOccurrences(of: "4.99", with: newPriceString.replacingOccurrences(of: "$", with: ""))
        result = result.replacingOccurrences(of: "4,99", with: newPriceString.replacingOccurrences(of: "$", with: ""))
        return result
    }
    
}
