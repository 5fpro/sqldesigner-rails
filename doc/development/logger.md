Logger
==================

## 索引

- 基礎 Class 說明
- 使用範例
- Lograge
- FAQ
- TODO

## 基礎 Class 說明

`ApplicationLogger`

  - 繼承自 Rails default logger
  - 讓繼承此 class 的 logger 可以在 class level 定義檔案路徑 (`.file_path`)

    ```ruby
    class ExampleLogger < Application
      file_path Rails.root.join('log', 'example.log')
    end
    ```

  - 沒有特別定義 file_path 的話，預設為 `Rails.root.join('log', "#{Rails.env}.log")`
  - 實作 singleton (`.default`)

    ```ruby
    class ExampleLogger < Application; end
    logger = ExampleLogger.default
    ```

`BaseLogger`

  - 繼承自 `Application`
  - 將原本寫 log 的 API，擴充成可以支援 Hash 或其他物件（後述），再轉換成 formatted string，原本只支援 string。
  - 透過 delegate 讓 `ExampleLogger.log` 等於 `ExampleLogger.default.log`，簡化使用。

## 使用範例


自定 log file path

  ```ruby
  class ExampleLogger < BaseLogger
    file_path Rails.root.join('log', 'example.log')
  end
  ```

基本 log 行為

  ```ruby
  ExampleLogger.log(test: 1, user_id: 2)
  ```

  - 相當於 `Rails.logger.info("logger=ExampleLogger test=1 user_id=2")`
  - default log level 為 info。

  ```ruby
  BaseLogger.log(test: 1, user_id: 2)
  ```

  - 相當於 `Rails.logger.info("test=1 user_id=2")`
  - BaseLogger 也可以直接用
  - BaseLogger 不會自動追加 `logger={Logger Class Name}` 的紀錄

使用不同的 log level


  ```ruby
  ExampleLogger.debug(test: 1, user_id: 2)
  ExampleLogger.info(test: 1, user_id: 2)
  ```

  - log levels list 同 Rails logger 可用的 (debug, info, error, fatal, unknow)。

  ```ruby
  ExampleLogger.error("Haha")
  ```

  - 也可以相容於最原始的用法

string / hash 以外的物件做為 input

  參考 commit https://github.com/Shopmatic/myshopmatic_core/commit/7818b548aae0789264cb41d90953b65d59adbf59#diff-6a792db12fa089a78b9d0dad065e2fa5

  1. `LogData` 的 `CLASS_MAP` 先加入該物件的 class ， value 為對應的 method
  2. 在對應的 method 內取用 `@obj` 就是所加入的 class 的 instance，再自行依需求轉成 Hash 或 string return 。

  ```ruby
  class LogData
    CLASS_MAP = {
      BaseForm => 'base_form'
    }
    ...
    private

    def base_form
      {
        error_message: @obj.errors.full_messages.join(','),
        class_name @obj.class.to_s
      }
    end
  end

  form = BillingForm.new
  ExampleLogger.log(form)
  ```

  - 用於複雜的物件處理或很多地方會重複用到時，就可以擴充 LogData。
  - [TODO] 未來 LogData 內容變多時，可以再改用別的 Design Pattern 拆分不同物件出去。

  ```ruby
  ExampleLogger.log(form, a: 1, b: 2)
  ```

  - 如果 log 了 custom object，想要再追加別的資料進去，可以直接在後面補。

  ```ruby
  ExampleLogger.debug(form, a: 1, b: 2) # raise error or not work :(
  ```

  - 注意！log 自定物件只適用於使用 `#log` 這個 method ，用 log level 來當 method 的話會失敗。

## Lograge

`config/initializer/lograge.rb`

  - 參考 gem 的說明文件。這裡最主要就是讓 controller reponse 後（包含有噴錯時），可以自定本來寫進 log file 的內容。
  - 如有要關閉此功能，例如在 staging or development 下，可以控制裡面的 `config.lograge.enabled`

## FAQ

我該繼承哪一個 Logger 比較好?

  - 如果想要使用 `BaseLogger` 的 `#log` 帶來的格式正規化與方便性，可以繼承 `BaseLogger`，不然的話，繼承 `ApplicationLogger` 就可以了

## TODO

1. `LogData` 內容日後要擴充的物件越來越多的話，可以用 STI 或其他 Design Pattern 擴充。

