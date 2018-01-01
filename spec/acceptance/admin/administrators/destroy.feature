Feature: 從後台更新分類
  Background:
    Given 超級管理者 登入
      And 已有 管理員:
          | name |
          | marsz |
  Scenario: 刪除管理員
    When 後台刪除 管理員(marsz)
    Then 頁面 轉跳
     And 管理員(marsz) 不存在
