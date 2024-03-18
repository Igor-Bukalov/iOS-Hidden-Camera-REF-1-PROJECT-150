
import Foundation
import StoreKit
import Pushwoosh
import Adjust

protocol IAPManagerProtocol_HSCF: AnyObject {
    func infoAlert_HSCF(title: String, message: String)
    func goToTheApp_HSCF()
    func failed()
}

class HSCFIAPManager: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    static let shared = HSCFIAPManager()
    weak var  transactionsDelegate: IAPManagerProtocol_HSCF?
    
    public var  localizablePrice = "$4.99"
    public var productBuy : PremiumMainControllerStyle_HSCF = .mainProduct
    public var productBought: [PremiumMainControllerStyle_HSCF] = []
    
    private var inMain: SKProduct?
    private var inUnlockContent: SKProduct?
    private var inUnlockFunc: SKProduct?
    private var inUnlockOther: SKProduct?
    
    private var mainProduct = Configurations_HSCF.mainSubscriptionID
    private var unlockContentProduct = Configurations_HSCF.unlockContentSubscriptionID
    private var unlockFuncProduct = Configurations_HSCF.unlockFuncSubscriptionID
    private var unlockOther = Configurations_HSCF.unlockerThreeSubscriptionID
    
    private var secretKey = Configurations_HSCF.subscriptionSharedSecret
    
    private var isRestoreTransaction = true
    private var restoringTransactionProductId: [String] = []
    
    private let iapError      = NSLocalizedString("error_iap", comment: "")
    private let prodIDError   = NSLocalizedString("inval_prod_id", comment: "")
    private let restoreError  = NSLocalizedString("faledRestore", comment: "")
    private let purchaseError = NSLocalizedString("notPurchases", comment: "")
    
    public func loadProductsFunc_HSCF() {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        SKPaymentQueue.default().add(self)
        let request = SKProductsRequest(productIdentifiers:[mainProduct,unlockContentProduct,unlockFuncProduct,unlockOther])
        request.delegate = self
        request.start()
    }
    
    
    public func doPurchase_HSCF() {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        switch productBuy {
        case .mainProduct:
            processPurchase_HSCF(for: inMain, with: Configurations_HSCF.mainSubscriptionID)
        case .unlockContentProduct:
            processPurchase_HSCF(for: inUnlockContent, with: Configurations_HSCF.unlockContentSubscriptionID)
        case .unlockFuncProduct:
            processPurchase_HSCF(for: inUnlockFunc, with: Configurations_HSCF.unlockFuncSubscriptionID)
        case .unlockOther:
            processPurchase_HSCF(for: inUnlockOther, with: Configurations_HSCF.unlockerThreeSubscriptionID)
        }
    }
    
    public func localizedPrice_HSCF() -> String {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        guard HSCFNetworkStatusMonitor.shared.isNetworkAvailable else { return localizablePrice }
        switch productBuy {
          case .mainProduct:
            processProductPrice(for: inMain)
          case .unlockContentProduct:
            processProductPrice(for: inUnlockContent)
          case .unlockFuncProduct:
            processProductPrice(for: inUnlockFunc)
        case .unlockOther:
            processProductPrice(for: inUnlockOther)
        }
        return localizablePrice
    }
    
    private func getCurrentProduct_HSCF() -> SKProduct? {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        
        switch productBuy {
        case .mainProduct:
            return self.inMain
        case .unlockContentProduct:
            return self.inUnlockContent
        case .unlockFuncProduct:
            return self.inUnlockFunc
        case .unlockOther:
            return self.inUnlockOther
        }
    }
    
    private func processPurchase_HSCF(for product: SKProduct?, with configurationId: String) {
        guard let product = product else {
            self.transactionsDelegate?.infoAlert_HSCF(title: iapError, message: prodIDError)
            return
        }
        if product.productIdentifier.isEmpty {
            func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
                var a = (game as! Decimal) + 300 + 30
                a += 95
                return treg == true || a == 30
            }
            
            self.transactionsDelegate?.infoAlert_HSCF(title: iapError, message: prodIDError)
        } else if product.productIdentifier == configurationId {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    
    public func doRestore_HSCF() {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        guard isRestoreTransaction else { return }
        SKPaymentQueue.default().restoreCompletedTransactions()
        isRestoreTransaction = false
    }
    
    
    private func completeRestoredStatusFunc_HSCF(restoreProductID : String, transaction: SKPaymentTransaction) {
        if restoringTransactionProductId.contains(restoreProductID) { return }
        restoringTransactionProductId.append(restoreProductID)
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        validateSubscriptionWithCompletionHandler(productIdentifier: restoreProductID) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.restoringTransactionProductId.removeAll {$0 == restoreProductID}
            if result {
                
                if let mainProd = self.inMain, restoreProductID == mainProd.productIdentifier {
                    self.transactionsDelegate?.goToTheApp_HSCF()
                    trackSubscription(transaction: transaction, product: mainProd)
                    
                }
                else if let firstProd = self.inUnlockFunc, restoreProductID == firstProd.productIdentifier {
                    trackSubscription(transaction: transaction, product: firstProd)
                    
                }
                else if let unlockContent = self.inUnlockContent, restoreProductID == unlockContent.productIdentifier {
                    trackSubscription(transaction: transaction, product: unlockContent)
                    
                }
            } else {
                self.transactionsDelegate?.infoAlert_HSCF(title: self.restoreError, message: self.purchaseError)
            }
        }
    }
    
    
    public func completeAllTransactionsFunc_HSCF() {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        let transactions = SKPaymentQueue.default().transactions
        for transaction in transactions {
            let transactionState = transaction.transactionState
            if transactionState == .purchased || transactionState == .restored {
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    private func getReciept() -> String? {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {


            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                print(receiptData)


                let receiptString = receiptData.base64EncodedString(options: [])
                return receiptString

                // Read receiptData.
            } catch { 
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
    
    // Ваша собственная функция для проверки подписки.
    public func validateSubscriptionWithCompletionHandler(productIdentifier: String,_ resultExamination: @escaping (Bool) -> Void) {
        SKReceiptRefreshRequest().start()
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        guard let receiptUrl = Bundle.main.appStoreReceiptURL,
              let receiptData = try? Data(contentsOf: receiptUrl) else {
            pushwooshSetSubTag(value: false)
            resultExamination(false)
            return
        }
        
        let receiptDataString = receiptData.base64EncodedString(options: [])
        
        let jsonRequestBody: [String: Any] = [
            "receipt-data": receiptDataString,
            "password": self.secretKey,
            "exclude-old-transactions": true
        ]
        
        let requestData: Data
        do {
            requestData = try JSONSerialization.data(withJSONObject: jsonRequestBody)
        } catch {
            print("Failed to serialize JSON: \(error)")
            pushwooshSetSubTag(value: false)
            resultExamination(false)
            return
        }
#warning("replace to release")
        //#if DEBUG
        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
        //#else
        //        let url = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
        //#endif
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to validate receipt: \(error) IAPManager")
                self.pushwooshSetSubTag(value: false)
                resultExamination(false)
                return
            }
            
            guard let data = data else {
                print("No data received from receipt validation IAPManager")
                self.pushwooshSetSubTag(value: false)
                resultExamination(false)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let latestReceiptInfo = json["latest_receipt_info"] as? [[String: Any]] {
                    for receipt in latestReceiptInfo {
                        if let receiptProductIdentifier = receipt["product_id"] as? String,
                           receiptProductIdentifier == productIdentifier,
                           let expiresDateMsString = receipt["expires_date_ms"] as? String,
                           let expiresDateMs = Double(expiresDateMsString) {
                            let expiresDate = Date(timeIntervalSince1970: expiresDateMs / 1000)
                            if expiresDate > Date() {
                                DispatchQueue.main.async {
                                    self.pushwooshSetSubTag(value: true)
                                    resultExamination(true)
                                }
                                return
                            }
                        }
                    }
                }
            } catch {
                print("Failed to parse receipt data 🔴: \(error) IAPManager")
            }
            
            DispatchQueue.main.async {
                self.pushwooshSetSubTag(value: false)
                resultExamination(false)
            }
        }
        task.resume()
    }
    
    
    func validateSubscriptions_HSCF_S32HP(productIdentifiers: [String], completion: @escaping ([String: Bool]) -> Void) {
        var results = [String: Bool]()
        let dispatchGroup = DispatchGroup()
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        for productIdentifier in productIdentifiers {
            dispatchGroup.enter()
            validateSubscriptionWithCompletionHandler(productIdentifier: productIdentifier) { isValid in
                results[productIdentifier] = isValid
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(results)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        Pushwoosh.sharedInstance().sendSKPaymentTransactions(transactions)
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        for transaction in transactions {
            if let error = transaction.error as NSError?, error.domain == SKErrorDomain {
                switch error.code {
                case SKError.paymentCancelled.rawValue:
                    print("User cancelled the request IAPManager")
                case SKError.paymentNotAllowed.rawValue, SKError.paymentInvalid.rawValue, SKError.clientInvalid.rawValue, SKError.unknown.rawValue:
                    print("This device is not allowed to make the payment IAPManager")
                default:
                    break
                }
            }
            
            switch transaction.transactionState {
            case .purchased:
                if let product = getCurrentProduct_HSCF() {
                    print("PRODUCT BOUGHT: ", product.productIdentifier)
                    productBought.append(productBuy)
                    if transaction.payment.productIdentifier == product.productIdentifier {
                        SKPaymentQueue.default().finishTransaction(transaction)
                        trackSubscription(transaction: transaction, product: product)
                        transactionsDelegate?.goToTheApp_HSCF()
                    }
                }
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionsDelegate?.failed()
                //transactionsDelegate?.infoAlert(title: "error", message: "something went wrong")
                print("Failed IAPManager")
                
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                completeRestoredStatusFunc_HSCF(restoreProductID: transaction.payment.productIdentifier, transaction: transaction)
                
            case .purchasing, .deferred:
                print("Purchasing IAPManager")
                
            default:
                print("Default IAPManager")
            }
        }
        completeAllTransactionsFunc_HSCF()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("requesting to product IAPManager")
        
        if let invalidIdentifier = response.invalidProductIdentifiers.first {
            print("Invalid product identifier:", invalidIdentifier , "IAPManager")
        }
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        guard !response.products.isEmpty else {
            print("No products available IAPManager")
            return
        }
        
        response.products.forEach({ productFromRequest in
            switch productFromRequest.productIdentifier {
            case Configurations_HSCF.mainSubscriptionID:
                inMain = productFromRequest
            case Configurations_HSCF.unlockContentSubscriptionID:
                inUnlockContent = productFromRequest
            case Configurations_HSCF.unlockFuncSubscriptionID:
                inUnlockFunc = productFromRequest
            case Configurations_HSCF.unlockerThreeSubscriptionID:
                inUnlockOther = productFromRequest
            default:
                print("error IAPManager")
                return
            }
            print("Found product: \(productFromRequest.productIdentifier) IAPManager")
        })
    }
    
    private func processProductPrice(for product: SKProduct?) {
        func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
            var a = (game as! Decimal) + 300 + 30
            a += 95
            return treg == true || a == 30
        }
        guard let product = product else {
            self.localizablePrice = "4.99 $"
            return
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        
        if let formattedPrice = numberFormatter.string(from: product.price) {
            self.localizablePrice = formattedPrice
        } else {
            self.localizablePrice = "4.99 $"
        }
    }
    
    private func pushwooshSetSubTag(value : Bool) {
        
        var tag = Configurations_HSCF.mainSubscriptionPushTag
        
        switch productBuy {
        case .mainProduct:
            print("continue IAPManager")
        case .unlockContentProduct:
            tag = Configurations_HSCF.unlockContentSubscriptionPushTag
        case .unlockFuncProduct:
            tag = Configurations_HSCF.unlockFuncSubscriptionPushTag
        case .unlockOther:
            tag = Configurations_HSCF.unlockerThreeSubscriptionPushTag
        }
        
        Pushwoosh.sharedInstance().setTags([tag: value]) { error in
            if let err = error {
                print(err.localizedDescription)
                print("send tag error IAPManager")
            }
        }
    }
    
    private func trackSubscription(transaction: SKPaymentTransaction, product: SKProduct) {
        if let receiptURL = Bundle.main.appStoreReceiptURL,
           let receiptData = try? Data(contentsOf: receiptURL) {
            func somDogAndwhaterver(game: NSNumber, treg: Bool, completion: () -> Void) -> Bool {
                var a = (game as! Decimal) + 300 + 30
                a += 95
                return treg == true || a == 30
            }
            let price = NSDecimalNumber(decimal: product.price.decimalValue)
            let currency = product.priceLocale.currencyCode ?? "USD"
            let transactionId = transaction.transactionIdentifier ?? ""
            let transactionDate = transaction.transactionDate ?? Date()
            let salesRegion = product.priceLocale.regionCode ?? "US"
            
            if let subscription = ADJSubscription(price: price, currency: currency, transactionId: transactionId, andReceipt: receiptData) {
                subscription.setTransactionDate(transactionDate)
                subscription.setSalesRegion(salesRegion)
                Adjust.trackSubscription(subscription)
            }
        }
    }
}
