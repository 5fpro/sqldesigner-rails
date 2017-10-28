Feature: 首頁
  Scenario: 首頁預設為 json
    When 前往 API首頁
      Then 頁面回應 正常
      And 回應格式為 JSON
  Scenario: 各種 404
    When 打 POST 到 API首頁
      Then 頁面回應 404
    When 前往 /_dwr/interface/WbmemberDWR.js
      Then 頁面回應 404
    When 前往 /asdasads
      Then 頁面回應 404
