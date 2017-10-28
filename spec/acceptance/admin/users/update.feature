Feature: 從後台更新 user
  Background:
    Given 管理者 登入
      And 已註冊 users:
          | name | email  |
          | marsz | marsz@5fpro.com  |
          | venus | venus@5fpro.com  |
  Scenario: 編輯頁面可正常載入
    When 前往 User(marsz) 的 後台使用者編輯頁面
    Then 頁面回應 正常
  Scenario: 不能把 email 更新為已存在的 user
    When 後台更新使用者 User(marsz):
         | email | venus@5fpro.com |
    Then 頁面回應 200
     And User(marsz) 的 email 沒有更新
  Scenario: 成功更新 user
    When 後台更新使用者 User(marsz):
         | name | jupiter |
    Then 頁面轉跳
     And User(marsz@5fpro.com) 的 name 更新為 'jupiter'
