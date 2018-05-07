Feature: 分類後台列表
  Background:
    Given 管理員 登入
      And 已有 category:
          | name  | tag_list |
          | Mars  | aa,bb |
          | Peter | bb |
  Scenario: 基本列表
    When 到後台 /categories
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 包含 Peter
  Scenario: 可搜尋
    When 到後台 /categories?q[tagged][]=aa
      Then 頁面回應 正常
       And 頁面 包含 Mars
       And 頁面 不含 Peter
    When 到後台 /categories?q[name_cont]=pe
      Then 頁面 不含 Mars
       And 頁面 包含 Peter
