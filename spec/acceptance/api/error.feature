Feature: 錯誤頁面
  Scenario: 錯誤
    When 打API GET 到 /error
      Then 頁面回應 401
      And 回應格式為 JSON
      And 回應內容符合
        """
        {
          error: {
            class_name: 'Tyr::Api::ClientAuthError',
            message: /(authenticate fail|驗證)/,
            backtrace: Array,
            context: {},
            original: nil
          }
        }
        """

