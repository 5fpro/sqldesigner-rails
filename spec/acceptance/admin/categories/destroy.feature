Feature: 從後台更新分類
  Background:
    Given 管理者 登入
      And 已有 分類:
          | name |
          | marsz |
  Scenario: 刪除分類
    When 後台刪除 分類(marsz)
    Then 頁面 轉跳
     And 分類(marsz) 不存在
  Scenario: 刪除後可再後台還原
    Given 後台刪除 分類(marsz)
      And 到後台 /categories
      And 頁面 不含 marsz
     When 後台還原 分類(marsz)!
      And 到後台 /categories
     Then 頁面 包含 marsz
      And 分類(marsz) 有存在
