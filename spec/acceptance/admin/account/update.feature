Feature: 管理員帳號頁面
  Background:
    Given 已有 管理員:
          | name  | email           |
          | marsz | marsz@5fpro.com |
          | venus | venus@5fpro.com |
      And 管理員(marsz) 登入
  Scenario: 帳號頁面可正常載入
    When 瀏覽 /admin/account
    Then 頁面回應 正常
  Scenario: 不能更新 Email、可以更新 name
    When 後台帳號更新:
         | email            | name |
         | marsz2@5fpro.com | mama |
    Then 頁面 轉跳
     And 管理員(mama) 的 email 為 'marsz@5fpro.com'
     And 管理員(mama) 的 name 為 'mama'
  Scenario: 更新密碼時必須輸入正確的舊密碼，才能更新成功
   Given 後台帳號更新:
         | current_password | password | password_confirmation |
         | 123123           | 12345678 | 12345678              |
     And 管理員(marsz) 密碼不為 '12345678'
     And 後台帳號更新:
         | password | password_confirmation |
         | 12345678 | 12345678              |
     And 管理員(marsz) 密碼不為 '12345678'
    When 後台帳號更新:
         | current_password | password | password_confirmation |
         | 12341234         | 12345678 | 12345678              |
    Then 管理員(marsz) 密碼為 '12345678'
     And 頁面 轉跳
  Scenario: 更新密碼失敗時，其他的資料也不會更新
    When 後台帳號更新:
         | password | name |
         | 12345678 | Mars |
    Then 管理員(marsz) 的 name 為 'marsz'
     And 管理員(marsz) 密碼不為 '12345678'
     And 頁面回應 200
