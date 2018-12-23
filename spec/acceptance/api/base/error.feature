Feature: 錯誤格式
  Scenario: 錯誤格式
    When 打API GET 到 /error
      Then 頁面回應 200
       And 回應內容符合
           """
           {
             error: {
               message: String,
               backtrace: Array,
               class_name: String,
               context: Hash
             }
           }
           """
