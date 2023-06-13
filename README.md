# ひこれす　-引っ越しレスキュー-
https://hikores.com
## サイト概要
### サイトテーマ
引っ越し先の地域を決める際の指標になるコミュニティサイト

### テーマを選んだ理由
自分が引越し先を選ぶ際に、いつも悩んでいる経験からこのテーマに決定しました。<br>
引越し先を選ぶ基準は人それぞれあると思います。<br>
会社から近い場所を選んだり、家賃との兼ね合いで場所を考えたり、<br>
リモートワークを推奨している会社ならあえて都会から離れた場所に住む等。<br>
事前にプラスの面、マイナスの面を知っていたらすごく心強いはずです。<br>
このサイトはそんな引っ越しに対する不安感を少しでも解消できればという思いで作りました。

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
- https://drive.google.com/file/d/1xO2jV1y5cHltQOdC5W9YV57ZvXbkAuGJ

### テーブル定義書
- https://docs.google.com/spreadsheets/d/1fnoCHRZmGs7c9PF9E5lPHbqMQi3vGC6xp5AcbgmUFDo

### テスト仕様書
- https://docs.google.com/spreadsheets/d/1_w39rZOoccsaaFAm6CxYlpCIhBvmeCPF

### AWS構成図
- https://drive.google.com/file/d/1KZi_I5Ytl5LfVZ5CAM3ur7tnNWjNoeYi/view?usp=sharing

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
