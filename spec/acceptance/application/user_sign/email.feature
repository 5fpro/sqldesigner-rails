Feature: Email 登入 / 登出
  Background:
    Given 已有 已註冊使用者:
          | name  | email           |
          | marsz | marsz@5fpro.com |
  Scenario: 未登入情況下，登入頁面正常載入
    When  瀏覽 /users/sign_in
    Then  頁面回應 正常
     And  Meta Title 包含 登入
     And  Meta Desc 包含 登入
  Scenario: 已登入情況下，登入頁面會轉跳
    Given User(marsz) 登入
    When  瀏覽 /users/sign_in
    Then  頁面 轉跳
  Scenario: 登入成功後頁面預設轉跳首頁
    When  瀏覽 POST 到 /users/sign_in
          """
          user:
            email: marsz@5fpro.com
            password: '12341234'
          """
    Then  User 已登入
    And   頁面 轉跳至 首頁
  Scenario: 登入失敗後頁面不轉跳
    When  瀏覽 POST 到 /users/sign_in
          """
          user:
            email: mars@5fpro.com
            password: '12341234'
          """
    Then  頁面回應 正常
    And   頁面 包含 "mars@5fpro.com"
    And   Meta Title 包含 登入
    And   Flash Message 有值
    And   User 未登入
