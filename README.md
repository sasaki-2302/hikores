# ひこれす　-引っ越しレスキュー-

## サイト概要
### サイトテーマ
引っ越し先の地域を決める際の指標になるコミュニティサイト

### テーマを選んだ理由
自分が引越し先を選ぶ際に、いつも悩んでいる経験からこのテーマに決定しました。<br>
また、このテーマに該当するサイトはなかったので、独自性のあるテーマとして周りと差別化を図っています。<br>
本題に入りますが、引越し先を選ぶ基準は人それぞれあると思います。<br>
会社から近い場所を選んだり、家賃との兼ね合いで場所を考えたり、リモートワークを推奨している会社ならあえて都会から離れて住む等。<br>
こんなプラスな制度があるなら引っ越したい、逆にこんなマイナス面があると知っていれば引っ越さなかった、誰しも悩んだ経験があるはずです。<br>
このサイトはユーザー投稿型の地域情報を共有できる場として、引っ越し先を見極める指標になればという思いで作りました。

### ターゲットユーザー
- 今、引っ越しを考えている方
- これから引っ越す場所を考える方

### 主な利用シーン
- 引越し先の雰囲気を知りたい時
- 得する制度があるかを知りたい時
- あまり知名度は無いが暮らしやすい場所を探す時

## 実装機能
### ユーザー側
- 投稿のCRUD機能
- 投稿の検索機能(都道府県名,市区町村名,投稿内容での絞り込み)
- 投稿へのコメント・いいね(非同期)
- ユーザー同士のフォロー・相互フォロー時のDM(非同期)
- ユーザーの通報機能
- ユーザーの退会機能
- ゲストユーザーの投稿,コメント,いいね,フォローを一定時間ごとに自動削除
- 問い合わせフォームの実装(Googleフォーム)

### 管理者側
- 投稿のCRUD機能
- ユーザーの退会・復帰を管理可能
- 通報内容の確認・対応状態をステータス化し確認可能

## 設計書
### ER図
- https://drive.google.com/file/d/1xO2jV1y5cHltQOdC5W9YV57ZvXbkAuGJ/view?usp=share_link

### テーブル定義書
- https://docs.google.com/spreadsheets/d/1fnoCHRZmGs7c9PF9E5lPHbqMQi3vGC6xp5AcbgmUFDo/edit?usp=share_link

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
### ロゴ(Shopify Hatchful)
- https://www.shopify.com/tools/logo-maker
### 日本地図(Jmap jQuery plugin)
- https://yugokimura.github.io/jmap/