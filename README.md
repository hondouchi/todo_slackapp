# 🤖 Slack Bot TODO App

Azure Container Apps + Cosmos DB を使用した、コスト効率重視の小規模チーム向け Slack Bot TODO アプリ

## 📋 プロジェクト概要

Slack ワークスペース内でメンション形式で TODO 管理ができるボットアプリケーションです。Azure の無料枠を最大限活用し、月額 1,000 円以下での運用を目指しています。

### 🎯 主要機能

- `@todobot add [内容]` - TODO 追加
- `@todobot list` - TODO 一覧表示
- `@todobot done [ID]` - TODO 完了
- `@todobot delete [ID]` - TODO 削除

### 🏗️ アーキテクチャ

- **フロントエンド**: Slack (メンション形式)
- **バックエンド**: Azure Container Apps (Slack Bolt)
- **データベース**: Azure Cosmos DB (NoSQL)
- **認証**: Slack OAuth Bot Token
- **CI/CD**: GitHub Actions

## 🚀 クイックスタート

### 前提条件

- Node.js 18+
- Docker
- Azure アカウント (無料枠)
- Slack ワークスペース管理者権限

### ローカル開発

```bash
# リポジトリクローン
git clone https://github.com/hondouchi/todo_slackapp.git
cd todo_slackapp

# 依存関係インストール
npm install

# 環境変数設定
cp .env.example .env
# .env ファイルを編集

# 開発サーバー起動
npm run dev
```

### デプロイ

詳細は [docs/deployment-guide.md](./docs/) を参照してください。

## 📚 ドキュメント

- [📐 アーキテクチャ設計書](./docs/architecture-design.md)
- [📋 要件定義書](./docs/requirements.md)
- [🔧 API 仕様書](./docs/api-specification.md) _(準備中)_
- [🚀 デプロイガイド](./docs/deployment-guide.md) _(準備中)_
- [👥 ユーザーガイド](./docs/user-guide.md) _(準備中)_

## 🛠️ 開発

### プロジェクト構造

```
todo_slackapp/
├── docs/                 # ドキュメント
├── src/                  # ソースコード (準備中)
├── tests/                # テスト (準備中)
├── .github/              # GitHub設定
│   ├── workflows/        # GitHub Actions
│   └── ISSUE_TEMPLATE/   # Issue テンプレート
├── docker/               # Docker設定 (準備中)
└── azure/                # Azure設定 (準備中)
```

### 開発フロー

1. Issue 作成（適切なテンプレート使用）
2. ブランチ作成 (`feature/issue-番号`)
3. 実装・テスト
4. Pull Request 作成
5. コードレビュー
6. マージ・デプロイ

## 📊 プロジェクト管理

- **Issues**: [GitHub Issues](https://github.com/hondouchi/todo_slackapp/issues)
- **マイルストーン**: [Phase 1 MVP 開発](https://github.com/hondouchi/todo_slackapp/milestones)
- **プロジェクトボード**: [Kanban Board](https://github.com/hondouchi/todo_slackapp/projects) _(設定予定)_

### 進捗状況

- ✅ **設計フェーズ** - 完了
- 🔄 **Phase 1: MVP 開発** - 進行中 (4 週間)
- ⏳ **Phase 2: 機能拡張** - 計画中 (2 週間)

## 💰 コスト目標

### 月額運用コスト (想定)

| サービス           | プラン     | 月額           |
| ------------------ | ---------- | -------------- |
| Container Apps     | 消費プラン | ¥0-200         |
| Cosmos DB          | 無料枠     | ¥0             |
| Container Registry | Basic      | ¥600           |
| Key Vault          | 標準       | ¥200           |
| **合計**           |            | **¥800-1,000** |

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. フィーチャーブランチ作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'feat: add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. Pull Request 作成

### コミットメッセージ規約

[Conventional Commits](https://www.conventionalcommits.org/) に準拠

```
feat: 新機能追加
fix: バグ修正
docs: ドキュメント更新
style: コードスタイル変更
refactor: リファクタリング
test: テスト追加・修正
chore: その他の変更
```

## 📄 ライセンス

このプロジェクトは [MIT License](LICENSE) の下で公開されています。

## 📞 サポート

- **Issues**: [GitHub Issues](https://github.com/hondouchi/todo_slackapp/issues)
- **Discussions**: [GitHub Discussions](https://github.com/hondouchi/todo_slackapp/discussions)
- **作成者**: [@hondouchi](https://github.com/hondouchi)

---

⭐ このプロジェクトが役に立ったら、ぜひスターを付けてください！
