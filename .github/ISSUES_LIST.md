# GitHub Issues 作成リスト

以下のマイルストーンと Issue を GitHub で作成してください。

## 🎯 マイルストーン

### 1. Phase 1: MVP 開発

- **タイトル**: `Phase 1: MVP開発`
- **説明**: `Slack Bot TODO機能の基本実装とAzureデプロイ`
- **期限**: `2025年9月27日` (4 週間後)

### 2. Phase 2: 機能拡張

- **タイトル**: `Phase 2: 機能拡張`
- **説明**: `期限設定・通知・レポート機能の追加`
- **期限**: `2025年10月11日` (6 週間後)

## 📋 Phase 1 Issues

### Week 1: 環境設定・基本機能実装

#### 1. [INFRA] Azure リソースグループ・基盤環境構築

```
**ラベル**: infrastructure, priority-high, component-azure
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Azure Resource Group作成
- Container Apps Environment作成
- Cosmos DB (無料枠) 作成
- Key Vault作成
```

#### 2. [FEATURE] Slack App 基本設定と OAuth 設定

```
**ラベル**: feature, priority-high, component-slack
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Slack App作成
- Bot Token設定
- Event Subscriptions設定
- OAuth & Permissions設定
```

#### 3. [FEATURE] Node.js Slack Bolt プロジェクト初期化

```
**ラベル**: feature, priority-high, component-api
**マイルストーン**: Phase 1: MVP開発
**説明**:
- プロジェクト構造作成
- package.json設定
- Slack Bolt SDK設定
- TypeScript設定
```

#### 4. [FEATURE] TODO 基本データモデル設計・実装

```
**ラベル**: feature, priority-high, component-api
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Cosmos DB接続設定
- TODOデータモデル定義
- 基本CRUD操作実装
```

### Week 2: Slack 統合・基本機能実装

#### 5. [FEATURE] TODO 追加機能実装 (@todobot add)

```
**ラベル**: feature, priority-high, component-slack
**マイルストーン**: Phase 1: MVP開発
**説明**:
- メンション解析機能
- TODO作成API実装
- Slack応答メッセージ実装
```

#### 6. [FEATURE] TODO 一覧表示機能実装 (@todobot list)

```
**ラベル**: feature, priority-high, component-slack
**マイルストーン**: Phase 1: MVP開発
**説明**:
- TODO一覧取得API実装
- Slack フォーマット表示
- ページング対応（オプション）
```

#### 7. [FEATURE] TODO 完了機能実装 (@todobot done)

```
**ラベル**: feature, priority-medium, component-slack
**マイルストーン**: Phase 1: MVP開発
**説明**:
- TODO状態更新API実装
- ID指定による操作
- 完了確認メッセージ
```

#### 8. [FEATURE] TODO 削除機能実装 (@todobot delete)

```
**ラベル**: feature, priority-medium, component-slack
**マイルストーン**: Phase 1: MVP開発
**説明**:
- TODO削除API実装
- ID指定による操作
- 削除確認メッセージ
```

### Week 3: Azure デプロイ・CI/CD・監視設定

#### 9. [INFRA] Docker ファイル作成とコンテナ化

```
**ラベル**: infrastructure, priority-high, component-azure
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Dockerfile作成
- .dockerignore設定
- ローカルコンテナテスト
```

#### 10. [INFRA] Azure Container Registry 設定

```
**ラベル**: infrastructure, priority-high, component-azure
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Container Registry作成
- イメージプッシュテスト
- 認証設定
```

#### 11. [INFRA] Container Apps デプロイ設定

```
**ラベル**: infrastructure, priority-high, component-azure
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Container Apps作成
- 環境変数設定
- スケーリング設定
```

#### 12. [INFRA] GitHub Actions CI/CD パイプライン構築

```
**ラベル**: infrastructure, priority-high, component-azure
**マイルストーン**: Phase 1: MVP開発
**説明**:
- GitHub Actions workflow作成
- Azure認証設定
- 自動ビルド・デプロイ設定
```

#### 13. [INFRA] Application Insights 監視設定

```
**ラベル**: infrastructure, priority-medium, component-azure
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Application Insights作成
- ログ設定
- アラート設定
```

### Week 4: テスト・本番リリース・ドキュメント

#### 14. [TEST] 統合テスト実装

```
**ラベル**: test, priority-high
**マイルストーン**: Phase 1: MVP開発
**説明**:
- API統合テスト
- Slack Bot動作テスト
- エラーハンドリング確認
```

#### 15. [DOCS] API 仕様書作成

```
**ラベル**: documentation, priority-medium
**マイルストーン**: Phase 1: MVP開発
**説明**:
- REST API仕様書
- Slack コマンド仕様
- エラーレスポンス仕様
```

#### 16. [DOCS] デプロイメント・運用ガイド作成

```
**ラベル**: documentation, priority-medium
**マイルストーン**: Phase 1: MVP開発
**説明**:
- セットアップガイド
- 運用マニュアル
- トラブルシューティングガイド
```

#### 17. [DOCS] ユーザーガイド作成

```
**ラベル**: documentation, priority-low
**マイルストーン**: Phase 1: MVP開発
**説明**:
- Slack Bot使用方法
- コマンド一覧
- FAQ
```

## 📋 Phase 2 Issues (将来実装)

#### 18. [FEATURE] TODO 期限設定機能

```
**ラベル**: feature, priority-medium, component-slack
**マイルストーン**: Phase 2: 機能拡張
**説明**: TODOに期限を設定する機能
```

#### 19. [FEATURE] 期限通知機能

```
**ラベル**: feature, priority-medium, component-slack
**マイルストーン**: Phase 2: 機能拡張
**説明**: 期限が近いTODOの自動通知
```

#### 20. [FEATURE] 定期タスク機能

```
**ラベル**: feature, priority-low, component-slack
**マイルストーン**: Phase 2: 機能拡張
**説明**: 定期的に繰り返すタスクの管理
```

---

## 🚀 Issue 作成手順

1. GitHub リポジトリ（https://github.com/hondouchi/todo_slackapp）にアクセス
2. **Issues** タブをクリック
3. **Milestones** で上記 2 つのマイルストーンを作成
4. **New Issue** で各 Issue を作成（テンプレート使用）
5. 適切なラベル・マイルストーン・アサインを設定

## 📊 推奨：GitHub Project 作成

- **Project name**: `Slack Bot TODO App`
- **Template**: `Kanban`
- **Automation**: Issues 自動追加設定
