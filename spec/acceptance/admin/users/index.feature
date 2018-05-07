Feature: 使用者後台列表
  Background:
    Given 管理員 登入
      And 已有 已註冊使用者:
          | name  |
          | Mars  |
          | Peter |
  Scenario: 基本列表
    When 到後台 /users
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 包含 Peter
  Scenario: 可搜尋
    When 到後台 /users?q[name_cont]=mars
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 不含 Peter
  Scenario: 可 CSV 格式匯出
    When 到後台 /users.csv
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 包含 Peter
    When 到後台 /users.csv?q[name_cont]=mars
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 不含 Peter
