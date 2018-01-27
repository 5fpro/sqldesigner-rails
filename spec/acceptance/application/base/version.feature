Feature: 讀取 Revision
  Scenario: html
    When 瀏覽 /version
    Then 頁面回應 正常
  Scenario: json
    When 瀏覽 /version.json
    Then 頁面回應 正常
