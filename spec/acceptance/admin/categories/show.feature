Feature: 分類後台明細頁
  Background:
    Given 管理員 登入
      And 已有 分類:
          | name  |
          | Mars  |
  Scenario: 前往後台 分類頁面
    When 到後台 GET 分類(Mars) 的 "/categories/:id"
    Then 頁面回應 正常
