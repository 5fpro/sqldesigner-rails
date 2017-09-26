Feature: 使用者後台列表
  Background:
    Given 管理者 登入
      And 已註冊 users:
          | name  |
          | Mars  |
          | Peter |
  Scenario: 基本列表
    When 前往 /admin/users
      Then 頁面回應 正常
       And 頁面包含 Mars
       And 頁面包含 Peter
  Scenario: 可搜尋
    When 前往 /admin/users?q[name_cont]=mars
      Then 頁面回應 正常
       And 頁面包含 Mars
       And 頁面不包含 Peter
  Scenario: 可 CSV 格式匯出
    When 前往 /admin/users.csv
      Then 頁面回應 正常
       And 頁面包含 Mars
       And 頁面包含 Peter
    When 前往 /admin/users.csv?q[name_cont]=mars
      Then 頁面回應 正常
       And 頁面包含 Mars
       And 頁面不包含 Peter
