# 自転車の在庫管理API

## 自転車登録API
自転車の登録を行います。  
ブランド名が新規のものならば、新ブランドが登録されます。  
すでに登録されているものは、同ブランドの自転車として登録されます。  
シリアルナンバーは異なるブランドでも一意である必要があります。
### リクエスト
 - ブランド名:      brand_name,     :string, :null false
 - シリアルナンバー: serial_number,  :string, :null false
### レスポンス
成功時、ステータスコード 201 を返します。  
要求バリデーションエラー時、ステータスコード 422 を返します。

### Example
#### request
```
POST /api/v1/bikes?brand_name=test&serial_number=hoge
```
#### response
```
Status 201 Created
{
    "data": {
        "id": 32,
        "brand_id": 4,
        "serial_number": "hoge",
        "sold_at": null,
        "created_at": "2020-04-06T14:08:49.377Z",
        "updated_at": "2020-04-06T14:08:49.377Z"
    }
}
```

## 自転車情報取得API
ブランドがもつ自転車を一覧で返します。  
### リクエスト
 - ブランド名:      brand_name,     :string, :null false
### レスポンス
成功時、自転車情報を含むdataオブジェクトを返します。  
要求ブランド名が存在しない場合、ステータスコード 404 を返します。

### Example
#### request
```
GET /api/v1/bikes?brand_name=test
```
#### response
```
Status 200 OK
{
    "data": [
        {
            "id": 31,
            "brand_id": 4,
            "serial_number": "1111212121",
            "sold_at": null,
            "created_at": "2020-04-06T11:33:32.665Z",
            "updated_at": "2020-04-06T11:33:32.665Z"
        },
        {
            "id": 32,
            "brand_id": 4,
            "serial_number": "hoge",
            "sold_at": null,
            "created_at": "2020-04-06T14:08:49.377Z",
            "updated_at": "2020-04-06T14:08:49.377Z"
        }
    ]
}
```

## 自転車売却API
自転車情報に、売却日（現在日時）を追加します。
### リクエスト
 - シリアルナンバー: serial_number,  :string, :null false
### レスポンス
成功時、ステータスコード 202 を返します。  
シリアルナンバーに該当する自転車情報が存在しない場合、ステータスコード 404 を返します。  
DB更新エラー発生時、ステータスコード 422 を返します。

### Example
#### request
```
PUT http://localhost:3000/api/v1/bikes?serial_number=hoge
```
#### response
```
Status 202 Accepted
{
    "data": {
        "id": 32,
        "sold_at": "2020-04-06T14:14:06.000Z",
        "serial_number": "hoge",
        "brand_id": 4,
        "created_at": "2020-04-06T14:08:49.377Z",
        "updated_at": "2020-04-06T14:14:06.865Z"
    }
}
```

## 主な使用ライブラリ
 - rubocop
 - bullet
 - rspec

## CIツール・その他
 - GitHub Actions
   - push時にrubocopとrspecで検証が行われます。
 - Dockerで起動できます。
