Feature: 從後台新增分類
  Background:
    Given 管理者 登入
      And 已有 category:
          | name  |
          | marsz |
  Scenario: 新增頁面可正常載入
    When 到後台 /categories/new
    Then 頁面回應 正常
  Scenario: 不能新增重複 name 的分類
    When 後台建立 分類:
         | name  |
         | marsz |
    Then 頁面回應 正常
     And 分類 數 不變
  Scenario: 成功建立分類
    When 後台建立 分類:
         | name |
         | marsz123 |
    Then 頁面 轉跳
     And 分類 數 +1
  Scenario: 不同參數
    When 後台建立 分類:
       """
       name: marsz123
       tag_list:
         - aa
         - bb
       """
    Then 分類(marsz123) 有標籤 aa
     And 分類(marsz123) 有標籤 bb
     And 分類(marsz123) 無標籤 cc
