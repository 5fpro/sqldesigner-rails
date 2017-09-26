Feature: 從後台更新 user
  Background:
    Given 管理者 登入
      And 已註冊 users:
          | name | email  |
          | marsz | marsz@5fpro.com  |
  Scenario: 刪除使用者
    When 後台刪除使用者 User(marsz)
    Then 頁面轉跳
     And User(marsz@5fpro.com) 不存在
