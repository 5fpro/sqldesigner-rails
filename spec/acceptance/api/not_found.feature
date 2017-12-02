Feature: 各種 404
  Scenario: 錯誤的 http method
    When 打API POST 到 首頁
      Then 頁面回應 404
      And 回應格式為 JSON
      And 回應內容符合
        """
        {
          error: {
            class_name: 'RoutingError',
            message: /Routing error/,
            backtrace: Array,
            context: Hash,
            original: {
              request: {
                protocol: 'http://',
                method: 'POST',
                params: Hash,
                headers: Hash
              }
            }
          }
        }
        """
  Scenario: 錯誤的路徑與 format
    When 打API /_dwr/interface/WbmemberDWR.js
      Then 頁面回應 404
      And 回應格式為 JSON
      And 回應內容符合
        """
        {
          error: {
            class_name: 'RoutingError',
            message: /Routing error/,
            backtrace: Array,
            context: Hash,
            original: {
              request: {
                full_path: /_dwr/,
                protocol: 'http://',
                method: 'GET',
                params: Hash,
                headers: Hash
              }
            }
          }
        }
        """
  Scenario: 錯誤的路徑
    When 打API /asdasads
      Then 頁面回應 404
      And 回應格式為 JSON
      And 回應內容符合
        """
        {
          error: {
            class_name: 'RoutingError',
            message: /Routing error/,
            backtrace: Array,
            context: Hash,
            original: {
              request: {
                full_path: /asdasads/,
                protocol: 'http://',
                method: 'GET',
                params: Hash,
                headers: Hash
              }
            }
          }
        }
        """
