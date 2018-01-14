Feature: 使用者後台明細頁
  Background:
    Given 管理者 登入
      And 已有 已註冊使用者:
          | name  |
          | Mars  |
  Scenario: 前往後台使用者頁面
    When 到後台 GET 使用者(Mars) 的 使用者頁面
    Then 頁面回應 正常
