# Phase 2.5: Slack App Web設定ガイド

## 概要

このガイドでは、Slack App Configuration（Web）を使用してSlackアプリを手動で作成・設定する方法を説明します。

## 前提条件

- Phase 1: プロジェクト環境構築が完了していること
- Phase 2: Slack Bot基本実装が完了していること
- Slackワークスペースの管理者権限またはアプリ作成権限を持っていること

## 1. Slack Appの作成

### 1.1 Slack API サイトでアプリを作成

1. [Slack API](https://api.slack.com/apps) にアクセス
2. 「Create New App」をクリック
3. 「From scratch」を選択
4. アプリ名を入力（例: `todo-slack-app`）
5. 開発するワークスペースを選択
6. 「Create App」をクリック

### 1.2 基本情報の設定

- **App Name**: `TODO Slack App`
- **Short Description**: `Simple TODO management bot for Slack`
- **Long Description**: `A Slack bot that helps users manage TODO tasks with simple commands and interactions`

## 2. アプリ機能の設定

### 2.1 Bot Userの有効化

1. 左サイドバーから「OAuth & Permissions」を選択
2. 「Scopes」セクションで「Bot Token Scopes」に以下を追加：
   ```
   app_mentions:read
   channels:history
   channels:read
   chat:write
   commands
   im:history
   im:read
   im:write
   users:read
   ```

### 2.2 Event Subscriptionsの設定

1. 左サイドバーから「Event Subscriptions」を選択
2. 「Enable Events」をオンにする
3. 「Request URL」は後でngrokを使用して設定
4. 「Subscribe to bot events」で以下のイベントを追加：
   ```
   app_mention
   message.channels
   message.im
   ```

### 2.3 Socket Modeの有効化（開発用）

1. 左サイドバーから「Socket Mode」を選択
2. 「Enable Socket Mode」をオンにする
3. App-Level Tokenの名前を入力（例: `socket-token`）
4. 必要なスコープ：`connections:write`

### 2.4 Slash Commandsの設定（オプション）

1. 左サイドバーから「Slash Commands」を選択
2. 「Create New Command」をクリック
3. コマンド例：
   ```
   Command: /todo
   Request URL: https://your-app.com/slack/events
   Short Description: Manage TODO tasks
   Usage Hint: add [task description] | list | complete [task_id]
   ```

## 3. トークンの取得と設定

### 3.1 必要なトークンの取得

1. **Bot User OAuth Token**:
   - 「OAuth & Permissions」→「Bot User OAuth Token」
   - `xoxb-` で始まるトークン

2. **App-Level Token**:
   - 「Basic Information」→「App-Level Tokens」
   - `xapp-` で始まるトークン

### 3.2 環境変数の設定

`.env`ファイルに以下を追加：

```bash
# Slack Configuration
SLACK_BOT_TOKEN=xoxb-your-bot-token-here
SLACK_APP_TOKEN=xapp-your-app-token-here
SLACK_SIGNING_SECRET=your-signing-secret-here

# App Configuration
NODE_ENV=development
PORT=3000
LOG_LEVEL=info

# Socket Mode for development
SLACK_SOCKET_MODE=true
```

### 3.3 Signing Secretの取得

- 「Basic Information」→「App Credentials」→「Signing Secret」

## 4. アプリのテスト

### 4.1 ワークスペースにインストール

1. 「OAuth & Permissions」→「Install to Workspace」
2. 権限を確認して「Allow」をクリック

### 4.2 動作確認

```bash
# 開発サーバーを起動
npm run dev

# または
npm start
```

### 4.3 テスト手順

1. Slackワークスペースでボットをチャンネルに招待
2. `@todo-slack-app hello` でメンション
3. ボットからの応答を確認

## 5. 本番環境への準備

### 5.1 Event Subscriptions URL設定

本番環境では以下のエンドポイントを設定：

```
https://your-domain.com/slack/events
```

### 5.2 環境変数の本番設定

```bash
# Production Environment
NODE_ENV=production
SLACK_SOCKET_MODE=false
PORT=8080

# Azure Container Apps用の設定
WEBSITES_PORT=8080
```

## 6. トラブルシューティング

### 6.1 よくある問題

- **Token認証エラー**: トークンの形式と権限を確認
- **Event subscription failed**: Request URLの到達性を確認
- **Socket Mode接続エラー**: App-Level Tokenとスコープを確認

### 6.2 デバッグ方法

```javascript
// src/config/app.ts でログレベルを debug に設定
export const config = {
  logLevel: 'debug',
};
```

## 7. 次のステップ

Phase 2.5完了後：

- [ ] Slack Appが正常に動作することを確認
- [ ] 環境変数が適切に設定されていることを確認
- [ ] Phase 3: Cosmos DB統合の準備

## 参考リンク

- [Slack API Documentation](https://api.slack.com/)
- [Bolt for JavaScript](https://slack.dev/bolt-js/concepts)
- [Socket Mode Guide](https://api.slack.com/apis/connections/socket)
