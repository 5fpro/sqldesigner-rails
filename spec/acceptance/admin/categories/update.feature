Feature: 從後台更新分類
  Background:
    Given 管理者 登入
      And 已有 分類:
          | name |
          | marsz |
          | venus |
  Scenario: 編輯頁面可正常載入
    When 到後台 GET 分類(marsz) 的 分類編輯頁面
    Then 頁面回應 正常
  Scenario: 不能把 name 更新為已存在的分類
    When 後台更新 分類(marsz):
         | name |
         | venus |
    Then 頁面回應 200
     And 分類(marsz) 的 name 為 'marsz'
  Scenario: 不能把 name 更新為空白字串
    When 後台更新 分類(marsz):
         | name |
         | |
    Then 頁面回應 200
     And 分類(marsz) 的 name 為 'marsz'
  Scenario: 成功更新分類
    When 後台更新 分類(marsz):
         | name |
         | jupiter |
    Then 頁面 轉跳
     And 分類(jupiter) 的 name 為 'jupiter'
  Scenario: 更新後會有版本記錄
    Given 後台更新 分類(marsz):
         | name |
         | jupiter |
    When 到後台 GET 分類(jupiter) 的 分類版本記錄頁面
    Then 頁面回應 200
     And 頁面 包含 marsz
