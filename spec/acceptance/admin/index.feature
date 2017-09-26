Feature: 基本驗證
  Scenario: 沒登入
    When 前往 /admin
      Then 頁面轉跳
    When 前往 /sidekiq
      Then 頁面轉跳
  Scenario: 非 admin 登入
    Given user 登入
      When 前往 /admin
        Then 頁面轉跳
      When 前往 /sidekiq
        Then 頁面回應 404
  Scenario: 非 admin 登入
    Given 管理者 登入
      When 前往 /admin
        Then 頁面回應 正常
      When 前往 /sidekiq
        Then 頁面回應 正常
