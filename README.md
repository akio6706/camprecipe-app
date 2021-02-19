# テーブル設計

## users テーブル

| Column             | Type    | Options                       |
| ------------------ | ------- | ----------------------------- |
| nickname           | string  | null: false                   |
| email              | string  | null: false, uniqueness: true |
| encrypted_password | string  | null: false                   |
| name               | string  | null: false                   |
| name_kana          | string  | null: false                   |

### Association

- has_many :recipes
- has_many :comments

## recipes テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| description | string     | null: false                    |
| level_id    | string     | null: false                    |
| user_id     | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :comments
- has_many :ingredients
- has_many :processes

## ingredients テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| ingredient | string     | null: false                    |
| amount     | string     | null: false                    |
| recipe_id  | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe

## processes テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| process   | string     | null: false                    |
| recipe_id | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | string     | null: false                    |
| recipe_id | references | null: false, foreign_key: true |
| user_id   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :recipe