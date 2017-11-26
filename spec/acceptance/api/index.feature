Feature: 首頁
  Scenario: 首頁預設為 json
    When 打API 首頁
      Then 頁面回應 正常
      And 回應格式為 JSON
