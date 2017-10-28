Feature: 從後台新增 user
  Background:
    Given 管理者 登入
      And 已註冊 users:
          | email  |
          | marsz@5fpro.com  |
  Scenario: 新增頁面可正常載入
    When 前往 後台新增使用者頁面
    Then 頁面回應 正常
  Scenario: 不能新增重複 Email 的 user
    When 後台建立使用者:
         | email | marsz@5fpro.com |
    Then 頁面回應 正常
     And 使用者數 不變
  Scenario: 成功建立 user
    When 後台建立使用者:
         | email | marsz123@5fpro.com |
    Then 頁面轉跳
     And 使用者數 +1
  Scenario: 夾帶檔案（頭像）測試
    When 後台建立使用者:
         | name | marsz123 |
         | avatar | y |
    Then 使用者(marsz123)有頭像
