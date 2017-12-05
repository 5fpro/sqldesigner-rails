錯誤處理
=============

## 索引

- 基礎物件 `ApplicationError`
  - 繼承
- Api 層的 Error
  - Rescued Error
  - Response Error
- Object 內的 Error
- TODO

## ApplicationError

### 基本宣告

```
e = ExampleException.new(message: nil, context: nil, original: nil)
```

  - message: 主要的錯誤訊息，顯示於前端用，沒有丟的話，會自動去吃 I18n。
  - context: 基本上為 Hash ，可在 exception service (Honeybadger.io, or Rollbar) 中查看其內容。
  - original: 原本的 Error object，如果想要紀錄原本的 Error，可使用此參數，通常在 rescue (or rescue_from) 區塊內，會需要丟入此參數。
  - 參數皆為 optional。

### 行為

```
e.notify
```

  - 噴到 exception service 上，但不 raise。

```
e.mail_deliver
```

  - 將 exception 內容包成信件內容通知系統管理員。
  - 通常用於需要人工處理的錯誤。

```
e.to_h
```

  - 將 error object 內的所有內容轉換成 hash。

```
e.log
```

  - 以單行格式，將 error 內容寫到 log 中，方便利用 papertrail 等 log service 搜尋。
  - 寫進 logger 的內容會以 `#to_h` 所 return 的內容為主。


### 繼承

  - ApplicationError 可以直接使用，無 interface method 要實作，但不建議如此。

直接繼承

  ```ruby
  class ExampleError < ApplicationError
  end
  ```

  - 會有不同的是在 `to_h`, `log`, 走 I18n 的 `message` 這三處，是依據 class name 的。

Error 內用自定的 logger

  ```
  class ExampleError < ApplicationError

    logger CustomLogger
  end

  class CustomLogger < BaseLogger
    file_path Rails.root.join('log', 'custom.log')
  end
  ```

  - 要用 `CustomLogger.debug` 或 `ExampleError.new.log` 來寫入 log 都可以。建議用 Error object 進行記錄會比較容易從 log 上看出來是從哪個 Error class 寫的 log。

追加 initialize 參數，並且使其為必填

  ```
  class ExampleError < ApplicationError
    private

    def custom_initialize(aa:, bb:)
      @aa = aa
      @bb = bb
      # or
      @context.merge!(aa: aa, bb: bb)
    end
  end

  ExampleError.new(aa: 'aa', bb: 'bb')
  ExampleError.new(aa: 'aa') # raise ArgumentError
  ```

擴充 `to_h` 所回傳的內容

  ```
  class ExampleError < ApplicationError

    private

    def custom_to_h
      {
        env: Rails.env
      }
    end
  end
  ```

  - 必 return Hash。
  - 若 Hash 的 key 有和定義在 `ApplicationError#to_h` 重疊的話，會以 `custom_to_h` return 的為主。
  - 搭配上述的 `custom_initialize` 加上 instance variable 可以完全自定:

    ```ruby
    class ExampleError < ApplicationError

      def custom_initialize(status: 400)
        @status = status
      end

      private

      def custom_to_h
        {
          status: @status
        }
      end
    end

    ExampleError.new(status: 500).to_h
    ```

## Api 層的 Error

物件說明:
  - `Api::BaseError`: 基礎 Error 物件，status 可用於 initialize 時指定或直接 overrider status method。
  - `Api::ControllerRescuedError`: 用於 rescue_from 時使用，後述。
  - `Api::RespondError`: 在 action 從 service object 等拿到錯誤結果，想要 API response error 時使用，後述。

### Rescued Error

`Api::ErrorResponseConcern`

  - 可讓各個 api base controller include 的 module。
  - 凡繼承自 `Api::BaseError` 的 Error object raise 時都會在這裡被 rescue。
  - 其餘非繼承自 `Api::BaseError` 的其他 error 被 rescue 時，會再被包進 `Api::ControllerRescuedError`，然後才 reponse，所以前述的 original 參數就會在這裡使用。

### Response Error

`Api::ErrorResponseConcern`

  - 在 action 內手動 response error。
  - `Api::RespondError` 的 raise 包在 `respond_error` 裡面了。

上述兩個可參考 `api/error_response_concern_spec.rb` 裡面的使用方式


## Object 內的 Error

### ObjectErrorsConcern

  - 概念上，Form object, service object 等需要儲存 error message 的 object 都可以 include 此 module。

```
self.errors = form.errors
```

  - 在 object 內呼叫別的 object 執行 fail 時，可將被呼叫的 object 內的 errors 搬到自己的 errors 裡


加入 error

  - 和 ActiveModel 的用法一樣

    ```ruby
    errors.add(:base, 'Message here')
    ```

  - Rails5 提供了 details 的功能，所以在 add error 時，可以走 key name 的模式

    ```ruby
    errors.add(:base, :not_found, message: 'Message here')
    ```

    - 若沒有特別指定 message 的話，就會走 I18n。

```
error?(attr = nil, name = nil)
```

  - 檢查是否有 error ，或特定 attribute 有 error
  - 若參數都沒有丟的話，就相當於 `!errors.empty?`。
  - 有丟 attr 的話，就相當於 `!errors[attr].empty?`
  - name 則是在在 column 下檢查是否有某個 error name 的錯，因只支援 rails 5 ，所以目前先關閉。

    ```ruby
    # only for Rails5
    errors.add(:email, :invalid)
    error?(:email, :invalid) # true

    errors.add(:email, 'Message')
    error? # true
    error?(:email) # true
    error?(:base) # false
    ```

```
error_message(attr = nil)
```

  - 將原本的 `errors.full_messages` 從 array 整理成 string （透過 `to_sentence`)
  - 沒有丟參數時，相當於 `errors.full_messages.uniq.to_sentence`
  - 有丟 attr 時，相當於 `errors.messages[attr.to_sym]&.to_sentence`

在 object 遇到重大 error 時，想直接中斷

  - define 一個 error (exception)，然後 raise 它，然後在 controller 層 rescue_from。
  - 遇到比較重大問題需要避免後續的執行時才用。
  - 避免自行 rescue ，造成開發和測試上的不方便。
    - 例外情況:
      - 打 request 時，有各種 Error 想要記錄，不噴 Error

        ```
          Mechanize.new.public_send(http_method, *args)
        rescue Mechanize::ResponseReadError => e
          XxxError.new(original_error: e).log
        rescue Mechanize::ResponseCodeError => e
          XxxError.new(original_error: e).log
        rescue Errno::ECONNRESET => e
          XxxError.new(original_error: e).log
        rescue Net::HTTP::Persistent::Error => e
          XxxError.new(original_error: e).log
        rescue Net::OpenTimeout => e
          XxxError.new(original_error: e).log
        rescue Errno::ENETUNREACH => e
          XxxError.new(original_error: e).log
        rescue SocketError => e
          XxxError.new(original_error: e).log
        ```

想看更多使用範例可參考 `object_errors_concern_spec.rb`

## TODO

