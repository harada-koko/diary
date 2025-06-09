# システム設計書

## アーキテクチャ選定
MVC（Model-View-Controller）

***

## コンテナ図
- **クライアント：** Webブラウザ
- **Webアプリケーション：** Ruby on Rails
- **データベース：** PostgreSQL
- **デプロイ環境：** Render

***

## コンポーネント図作成
- **View：** タイムライン、投稿フォームなど
- **Controller：** 投稿の追加、編集、削除、ユーザー認証など
- **Model：** User, Post など
- **Database：** PostgreSQL

各コンポーネントはMVC構造に従い、以下のように分担します。
- **View：** 画面表示とフォーム入力の受け付け
- **Controller：** ルーティングと処理の制御
- **Model：** データの管理、ビジネスロジック、他モデルとの関連づけ

***

## データモデル設計
### エンティティ一覧
| エンティティ名 | 説明 |
| :--- | :--- |
| **User** | 利用者情報 |
| **Post** | 投稿情報（日報やつぶやき） |

### 関係性（リレーション）
- **User 1 : N Post** ひとりのユーザーが複数の投稿をもつ

### Userテーブルの属性
| カラム名 | 型 | 制約 | 備考 |
| :--- | :--- | :--- | :--- |
| `id` | integer | 主キー | 自動採番 |
| `name` | string | NOT NULL | ニックネーム |
| `email` | string | NOT NULL, UNIQUE | ログインに使うメールアドレス |
| `password_digest` | string | NOT NULL | パスワードのハッシュ |
| `created_at` | datetime | NOT NULL | レコード作成日時 |
| `updated_at` | datetime | NOT NULL | レコード更新日時 |

### Postテーブルの属性
| カラム名 | 型 | 制約 | 備考 |
| :--- | :--- | :--- | :--- |
| `id` | integer | 主キー | 自動採番 |
| `user_id` | integer | NOT NULL | 外部キー（Userテーブルのid） |
| `content` | text | NOT NULL | 投稿の本文 |
| `post_type` | string | | 投稿の種類（例: "日報", "つぶやき"） |
| `created_at` | datetime | NOT NULL | レコード作成日時 |
| `updated_at` | datetime | NOT NULL | レコード更新日時 |

### ER図
```mermaid
erDiagram
    User ||--o{ Post : "posts"

    User {
        int id PK
        string name "NOT NULL"
        string email "NOT NULL, UNIQUE"
        string password_digest "NOT NULL"
        datetime created_at "NOT NULL"
        datetime updated_at "NOT NULL"
    }

    Post {
        int id PK
        int user_id FK "NOT NULL"
        text content "NOT NULL"
        string post_type
        datetime created_at "NOT NULL"
        datetime updated_at "NOT NULL"
    }