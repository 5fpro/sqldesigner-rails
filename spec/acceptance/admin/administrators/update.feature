Feature: 從後台更新管理員
  Background:
    Given 超級管理者 登入
      And 已有 管理員:
          | name  | email           |
          | marsz | marsz@5fpro.com |
          | venus | venus@5fpro.com |
  Scenario: 編輯頁面可正常載入
    When 到後台 GET 管理員(marsz) 的 管理員編輯頁面
    Then 頁面回應 正常
  Scenario: 不能把 email 更新為已存在的管理員
    When 後台更新 管理員(marsz):
         | email           |
         | venus@5fpro.com |
    Then 頁面回應 200
     And 管理員(marsz) 的 email 為 'marsz@5fpro.com'
  Scenario: 不能把 email 更新為空白字串
    When 後台更新 管理員(marsz):
         | email |
         |       |
    Then 頁面回應 200
     And 管理員(marsz) 的 name 為 'marsz'
  Scenario: 成功更新管理員
    When 後台更新 管理員(marsz):
         | name    |
         | jupiter |
    Then 頁面 轉跳
     And 管理員(marsz@5fpro.com) 的 name 為 'jupiter'
  Scenario: 更新時密碼可以是空值
    When 後台更新 管理員(marsz):
         | password |
         |          |
    Then 頁面 轉跳
  Scenario: 可更新管理登入密碼
    When 後台更新 管理員(marsz):
         | password |
         | abcd1234 |
    Then 頁面 轉跳
     And 管理員(marsz) 密碼為 'abcd1234'



