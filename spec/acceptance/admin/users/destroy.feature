Feature: 從後台更新 user
  Background:
    Given 管理員 登入
      And 已有 已註冊使用者:
          | name | email  |
          | marsz | marsz@5fpro.com  |
  Scenario: 刪除使用者
    When 後台刪除 使用者(marsz)
    Then 頁面 轉跳
     And 使用者(marsz@5fpro.com) 不存在
