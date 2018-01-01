Feature: 管理員後台明細頁
  Background:
    Given 超級管理者 登入
      And 已有 管理員:
          | name  |
          | Mars  |
  Scenario: 前往後台 管理員頁面
    When 到後台 GET 管理員(Mars) 的 管理員頁面
    Then 頁面回應 正常
