Feature: 管理者後台列表
  Background:
    Given 超級管理者 登入
      And 已有 管理員:
          | name  |
          | Mars  |
          | Peter |
  Scenario: 基本列表
    When 到後台 /administrators
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 包含 Peter
  Scenario: 可搜尋
    When 到後台 /administrators?q[name_cont]=ma
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 不含 Peter
    When 到後台 /administrators?q[name_cont]=pe
      Then 頁面 不含 Mars
       And 頁面 包含 Peter
