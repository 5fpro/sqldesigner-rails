Feature: 從後台新增 user
  Background:
    Given 管理員 登入
      And 已有 已註冊使用者:
          | email  |
          | marsz@5fpro.com  |
  Scenario: 新增頁面可正常載入
    When 到後台 /users/new
    Then 頁面回應 正常
  Scenario: 不能新增重複 Email 的 user
    When 後台建立 使用者:
         | email |
         | marsz@5fpro.com |
    Then 頁面回應 正常
     And 使用者 數 不變
  Scenario: 成功建立 user
    When 後台建立 使用者:
         | email |
         | marsz123@5fpro.com |
    Then 頁面 轉跳
     And 使用者 數 +1
  Scenario: 夾帶檔案（頭像）測試
    When 後台建立 使用者:
         | name     | avatar |
         | marsz123 | file_data |
    Then User(marsz123) 有頭像
