Feature: Examples from model_steps.rb
  Scenario Outline:
      When 已有 分類:
           | id | name            | tag_list   |
           | 1  | Badminton Store | sport,ball |
      Then 分類(1) 的 name <string_match_type> "<string_match_value>"
       And 分類(1) 的 name 為 "Badminton Store"
       And 分類(1) 有存在
       And 分類(2) 不存在
       And 分類(1) 有標籤 sport
       And 分類(1) 無標籤 eat
      Examples:
           | string_match_type | string_match_value |
           | 包含               | min                |
           | 不含               | haha               |
           | 有值               |                    |
           | 符合               | ^[A-Z]+[a-z]+      |
           | 不符               | [0-9]+             |

