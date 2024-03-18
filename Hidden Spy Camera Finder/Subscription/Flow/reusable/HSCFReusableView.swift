//  Created by Alexander N on 14.07.2023
//


import UIKit

enum configView_HSCF {
    case first,second,transaction
}

protocol ReusableViewEvent_HSCF : AnyObject {
    func nextStep(config: configView_HSCF)
}

struct ReusableViewModel_HSCF {
    var title : String
    var items : [ReusableContentCell_HSCF]
}

struct ReusableContentCell_HSCF {
    var title : String
    var image : UIImage
    var selectedImage: UIImage
}

class HSCFReusableView: UIView, AnimatedButtonEvent_HSCF {
    func onClick_HSCF() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        self.protocolElement?.nextStep(config: self.configView)
    }
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLb: UILabel!
    @IBOutlet private weak var content: UICollectionView!
    @IBOutlet private weak var nextStepBtn: HSCFAnimatedButton!
    @IBOutlet private weak var titleWight: NSLayoutConstraint!
    @IBOutlet private weak var buttonBottom: NSLayoutConstraint!
    
    weak var protocolElement : ReusableViewEvent_HSCF?
    
    public var configView : configView_HSCF = .first
    public var viewModel : ReusableViewModel_HSCF? = nil
    private let cellName = "HSCFReusableCell_HSCF"
    private var selectedStorage : [Int] = []
    private let multic: CGFloat = 0.94
    private let xib = "HSCFReusableView"
    
 
    
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
                // Устройство без физической кнопки "Home" (например, iPhone X и новее)
            } else {
                // Устройство с физической кнопкой "Home"
                buttonBottom.constant = 47
            }
        } else {
            buttonBottom.constant = 63
        }

        contentView.fixInView_HSCF(self)
        nextStepBtn.delegate = self
        nextStepBtn.style = .native
        contentView.backgroundColor = .clear
        setContent_HSCF()
        setConfigLabels_TOC_HSCF()
        configScreen_TOC_HSCF()
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            let layout = HSCFRTLSupportedCollectionViewFlowLayout_HSCF2()
            layout.scrollDirection = .horizontal
            content.collectionViewLayout = layout
        }
    }
    
    private func setContent_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        content.dataSource = self
        content.delegate = self
        content.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        content.backgroundColor = .clear
//        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }
    
    private func setConfigLabels_TOC_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        titleLb.setShadow_S32HP()
        
        titleLb.textColor = .white
        titleLb.font = UIFont(name: Configurations_HSCF.getSubFontName_HSCF(), size: 24)
//        titleLb.lineBreakMode = .byWordWrapping
        titleLb.adjustsFontSizeToFitWidth = true
    }
    
    public func setConfigView_HSCF(config: configView_HSCF) {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.configView = config
    }
    
    private func setLocalizable_HSCF() {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        self.titleLb.text = viewModel?.title
    }
    
    //MARK: screen configs
    
    private func configScreen_TOC_HSCF(){
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleWight.setValue(0.35, forKey: "multiplier")
        } else {
            titleWight.setValue(0.7, forKey: "multiplier")
        }
    }
    
    func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
        var a = (game as! Decimal) + 300 + 30
        a += 95
        return treg == true || a == 30
    }
    
    private func getLastElementHSCF() -> Int {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        return (viewModel?.items.count ?? 0) - 1
    }
}

extension HSCFReusableView : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setLocalizable_HSCF()
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        let cell = content.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! HSCFReusableCell_HSCF
        let content = viewModel?.items[indexPath.item]
        cell.cellLabel.text = content?.title.uppercased()
        if selectedStorage.contains(where: {$0 == indexPath.item}) {
            cell.cellLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell.cellImage.image = content?.selectedImage
            cell.contentContainer.backgroundColor = #colorLiteral(red: 0.7372549176, green: 0.7372549176, blue: 0.7372549176, alpha: 1)
            cell.cellLabel.font = UIFont(name: Configurations_HSCF.getSubFontName_HSCF(), size: 12)
            cell.cellLabel.setShadow_S32HP(with: 0.25)
        } else {
            cell.cellLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            cell.cellImage.image = content?.image
            cell.contentContainer.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)
            cell.cellLabel.font = UIFont(name: Configurations_HSCF.getSubFontName_HSCF(), size: 10)
            cell.cellLabel.setShadow_S32HP(with: 0.5)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedStorage.contains(where: {$0 == indexPath.item}) {
            selectedStorage.removeAll(where: {$0 == indexPath.item})
        } else {
            selectedStorage.append(indexPath.row)
        }
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        UIApplication.shared.impactFeedbackGenerator_HSCF(type: .light)
        collectionView.reloadData()
        collectionView.performBatchUpdates(nil, completion: nil)
        if indexPath.last == getLastElementHSCF() {
            collectionView.scrollToLastItem_HSCF(animated: false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        return selectedStorage.contains(indexPath.row) ? CGSize(width: collectionView.frame.height * 0.8, height: collectionView.frame.height) : CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height * 0.85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
}

class HSCFRTLSupportedCollectionViewFlowLayout_HSCF2: UICollectionViewFlowLayout {

    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
