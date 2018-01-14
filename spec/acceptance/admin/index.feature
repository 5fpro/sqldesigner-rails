Feature: 基本驗證
  Scenario: 沒登入
    When 到後台 首頁
      Then 頁面 轉跳
    When 瀏覽 /sidekiq
      Then 頁面 轉跳
  Scenario: 非 admin 登入
    Given 使用者 登入
      When 到後台 首頁
        Then 頁面 轉跳
      When 瀏覽 /sidekiq
        Then 頁面 轉跳
  Scenario: 非 admin 登入
    Given 管理者 登入
      When 到後台 首頁
        Then 頁面回應 正常
      When 瀏覽 /sidekiq
        Then 頁面回應 正常
