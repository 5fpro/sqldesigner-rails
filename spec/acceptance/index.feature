Feature: 基本頁面
  Scenario: 首頁正常
    When 前往 首頁
      Then 頁面回應 正常
  Scenario: robots.txt 正常回應
    When 前往 /robots.txt
      Then 頁面回應 正常
      And 回應內容不含 '<html'
      And 回應格式為 text
    When 前往 /robots
      Then 頁面回應 404
  Scenario: 各種 404
    When 打 POST 到 首頁
      Then 頁面回應 404
    When 前往 /_dwr/interface/WbmemberDWR.js
      Then 頁面回應 404
    When 前往 /asdasads
      Then 頁面回應 404
