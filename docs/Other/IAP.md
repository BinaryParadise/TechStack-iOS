# In-App Purchase

苹果应用内购买俗称内购

## 主要流程

框架：StoreKit

```swi
//添加交易监听
SKPaymentQueue.default().add(self)

//获取产品信息
let request = SKProductsRequest(productIdentifiers: ["productId"])
request.delegate = self
request.start()

//获取完成回调
extension [Class]: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let product = response.products.first else {
            return
        }
        let payment = SKPayment(product: product)
        //发起购买请求
        SKPaymentQueue.default().add(payment)
    }
}

//购买结果
extension [Class]: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased,//购买成功
                 .restored://回复成功
                //TODO: 需要和后端校验
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed://购买失败
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
        
    }
}
```



## 消耗型

## 自动续订周期

- 【沙盒】最多产生6笔订单，完成后可以删除App继续测试自动订阅
- 自动续订成功后，关掉App，超过持续时间时打开App，检查能否生成续订订单
- 间隔时间大于一笔订单时，该如何处理

| 实际持续时间 |  沙箱持续时间 |
| --- | --- |
| 1 week   | 3 minutes |
| 1 month  | 5 minutes |
| 2 months | 10 minutes |
| 3 months | 15 minutes |
| 6 months | 30 minutes |
| 1 year   | 1 hour|
