Feature: 從後台新增管理員
  Background:
    Given 超級管理者 登入
      And 已有 管理員:
          | name  | email           |
          | marsz | marsz@5fpro.com |
  Scenario: 新增頁面可正常載入
    When 到後台 /administrators/new
    Then 頁面回應 正常
  Scenario: 不能新增重複 email 的分類
    When 後台建立 管理員:
         | email           |
         | marsz@5fpro.com |
    Then 頁面回應 正常
     And 管理員 數 不變
  Scenario: 建立時，密碼不能為空
    When 後台建立 管理員:
         | password |
         |          |
    Then 頁面回應 正常
     And 管理員 數 不變
  Scenario: 成功建立管理員
    When 後台建立 管理員:
         | name     |
         | marsz123 |
    Then 頁面 轉跳
     And 管理員 數 +1
