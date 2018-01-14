Feature: 非超級管理員，無法後台管理操作其他管理員
  Scenario: 所有不能進行的操作
    Given 管理者 登入
      And 已有 管理員:
          | name  | email           |
          | marsz | marsz@5fpro.com |
      And 瀏覽 /admin
      And 頁面回應 正常
      And 瀏覽 /admin/administrators
      And 頁面 轉跳至 /admin
      And 瀏覽 /admin/administrators/new
      And 頁面 轉跳至 /admin
      And 瀏覽 /admin/administrators/1
      And 頁面 轉跳至 /admin
      And 後台建立 管理員:
          | name     |
          | marsz123 |
      And 頁面 轉跳至 /admin
      And 後台更新 管理員(marsz):
          | email           |
          | venus@5fpro.com |
      And 頁面 轉跳至 /admin
      And 後台刪除 管理員(marsz)
      And 頁面 轉跳至 /admin
     When 跟隨頁面轉跳
      And 頁面回應 正常
