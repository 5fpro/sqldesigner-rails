Feature: 從後台更新 user
  Background:
    Given 管理者 登入
      And 已有 已註冊使用者:
          | name | email  |
          | marsz | marsz@5fpro.com  |
          | venus | venus@5fpro.com  |
  Scenario: 編輯頁面可正常載入
    When 到後台 GET 使用者(marsz) 的 使用者編輯頁面
    Then 頁面回應 正常
  Scenario: 不能把 email 更新為已存在的 user
    When 後台更新 使用者(marsz):
         | email |
         | venus@5fpro.com |
    Then 頁面回應 200
     And 使用者(marsz) 的 email 為 'marsz@5fpro.com'
  Scenario: 成功更新 user
    When 後台更新 使用者(marsz):
         | name |
         | jupiter |
    Then 頁面 轉跳
     And 使用者(marsz@5fpro.com) 的 name 為 'jupiter'
