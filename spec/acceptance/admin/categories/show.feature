Feature: 分類後台列表
  Background:
    Given 管理者 登入
      And 已有 分類:
          | name  |
          | Mars  |
  Scenario: 前往後台 使用者頁面
    When 到後台 GET 分類(Mars) 的 分類頁面
    Then 頁面回應 正常
