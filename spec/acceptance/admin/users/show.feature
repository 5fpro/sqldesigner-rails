Feature: 使用者後台列表
  Background:
    Given 管理者 登入
      And 已註冊 users:
          | name  |
          | Mars  |
  Scenario: 前往後台使用者頁面
    When 前往 User(Mars) 的 後台使用者頁面
    Then 頁面回應 正常
