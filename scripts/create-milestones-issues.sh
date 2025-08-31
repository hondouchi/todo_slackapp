#!/bin/bash

# GitHub Milestones & Issues 作成スクリプト
# Usage: bash scripts/create-milestones-issues.sh

set -e

echo "🎯 GitHub マイルストーン & Issues 作成開始..."

# マイルストーン作成
echo "📋 マイルストーン作成中..."

echo "  Creating Phase 1: MVP開発..."
gh api repos/hondouchi/todo_slackapp/milestones \
  --method POST \
  --field title="Phase 1: MVP開発" \
  --field description="Slack Bot TODO機能の基本実装とAzureデプロイ

【含まれる機能】
- Azure基盤環境構築
- Slack Bot基本機能（add/list/done/delete）
- Container Apps デプロイ
- CI/CD パイプライン構築
- 基本的な監視・ログ設定

【完了条件】
- 全てのTODO基本機能が動作
- Azure本番環境でのデプロイ完了
- ユーザーガイド・運用ドキュメント整備" \
  --field due_on="2025-09-27T23:59:59Z" \
  --field state="open"

echo "  Creating Phase 2: 機能拡張..."
gh api repos/hondouchi/todo_slackapp/milestones \
  --method POST \
  --field title="Phase 2: 機能拡張" \
  --field description="期限設定・通知・レポート機能の追加

【含まれる機能】
- TODO期限設定機能
- 期限通知機能（Slack通知）
- 定期タスク機能
- 基本的なレポート・分析機能

【完了条件】
- 期限管理機能の実装完了
- 通知システムの動作確認
- 拡張機能のドキュメント整備" \
  --field due_on="2025-10-11T23:59:59Z" \
  --field state="open"

echo "✅ マイルストーン作成完了！"

# マイルストーン番号を取得
MILESTONE_1=$(gh api repos/hondouchi/todo_slackapp/milestones | jq -r '.[] | select(.title=="Phase 1: MVP開発") | .number')
MILESTONE_2=$(gh api repos/hondouchi/todo_slackapp/milestones | jq -r '.[] | select(.title=="Phase 2: 機能拡張") | .number')

echo "📌 Phase 1 マイルストーン番号: $MILESTONE_1"
echo "📌 Phase 2 マイルストーン番号: $MILESTONE_2"

echo ""
echo "🎫 Issues 作成中..."

# Phase 1 Issues作成
echo "  Week 1: 環境設定・基本機能実装"

gh issue create \
  --title "[INFRA] Azure リソースグループ・基盤環境構築" \
  --body "## 🏗️ インフラタスク概要
Azure基盤環境の構築

## 🎯 作業内容
- [ ] Azure Resource Group作成
- [ ] Container Apps Environment作成
- [ ] Cosmos DB (無料枠) 作成
- [ ] Key Vault作成
- [ ] リソース間の接続確認

## 📊 Azure リソース
- **リソースグループ**: rg-todo-slackapp
- **サービス**: Container Apps, Cosmos DB, Key Vault
- **リージョン**: Japan East

## ✅ 完了条件
- [ ] 全てのAzureリソースが作成済み
- [ ] 接続確認テスト完了
- [ ] 無料枠の設定確認完了" \
  --label "infrastructure,priority-high,component-azure" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[FEATURE] Slack App基本設定とOAuth設定" \
  --body "## 📋 機能概要
Slack Appの作成とOAuth認証設定

## 🎯 実装内容
- [ ] Slack App作成 (Slack API管理画面)
- [ ] Bot Token設定
- [ ] Event Subscriptions設定
- [ ] OAuth & Permissions設定
- [ ] Scopes設定 (chat:write, channels:read, etc.)

## ✅ 完了条件
- [ ] Slack Appが正常に作成される
- [ ] Bot Tokenが発行される
- [ ] 必要な権限が設定される
- [ ] テストワークスペースで動作確認" \
  --label "feature,priority-high,component-slack" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[FEATURE] Node.js Slack Bolt プロジェクト初期化" \
  --body "## 📋 機能概要
Slack Bolt SDKを使用したNode.jsプロジェクトの初期化

## 🎯 実装内容
- [ ] プロジェクト構造作成
- [ ] package.json設定
- [ ] Slack Bolt SDK設定
- [ ] TypeScript設定
- [ ] 環境変数設定 (.env)
- [ ] 基本的なSlack接続テスト

## 📝 技術仕様
- Node.js 18 LTS
- TypeScript
- Slack Bolt SDK
- 環境変数管理

## ✅ 完了条件
- [ ] プロジェクト構造が完成
- [ ] Slack Bolt基本接続が動作
- [ ] TypeScript設定が完了" \
  --label "feature,priority-high,component-api" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[FEATURE] TODO基本データモデル設計・実装" \
  --body "## 📋 機能概要
Cosmos DBを使用したTODOデータモデルの設計と基本CRUD実装

## 🎯 実装内容
- [ ] Cosmos DB接続設定
- [ ] TODOデータモデル定義
- [ ] 基本CRUD操作実装 (Create, Read, Update, Delete)
- [ ] データベース初期化スクリプト
- [ ] 基本的なエラーハンドリング

## 📝 技術仕様
```javascript
{
  \"id\": \"unique-uuid\",
  \"title\": \"買い物に行く\",
  \"status\": \"pending|completed\",
  \"createdAt\": \"2025-08-30T10:00:00Z\",
  \"completedAt\": \"2025-08-30T15:30:00Z\",
  \"userId\": \"slack-user-id\",
  \"userName\": \"user-display-name\",
  \"channelId\": \"slack-channel-id\"
}
```

## ✅ 完了条件
- [ ] Cosmos DB接続が動作
- [ ] CRUD操作が全て実装済み
- [ ] データモデルのテスト完了" \
  --label "feature,priority-high,component-api" \
  --milestone "$MILESTONE_1"

echo "  Week 2: Slack統合・基本機能実装"

gh issue create \
  --title "[FEATURE] TODO追加機能実装 (@todobot add)" \
  --body "## 📋 機能概要
Slackメンション形式でのTODO追加機能

## 🎯 実装内容
- [ ] メンション解析機能 (@todobot add [内容])
- [ ] TODO作成API実装
- [ ] Slack応答メッセージ実装
- [ ] 入力バリデーション
- [ ] エラーハンドリング

## 📝 技術仕様
- コマンド形式: @todobot add [タスク内容]
- 応答: \"✅ TODO「[タスク内容]」を追加しました（ID: [数字]）\"

## ✅ 完了条件
- [ ] メンション解析が動作
- [ ] TODO作成機能が動作
- [ ] 適切な応答メッセージが表示" \
  --label "feature,priority-high,component-slack" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[FEATURE] TODO一覧表示機能実装 (@todobot list)" \
  --body "## 📋 機能概要
TODOの一覧表示機能

## 🎯 実装内容
- [ ] TODO一覧取得API実装
- [ ] Slack フォーマット表示
- [ ] ページング対応（オプション）
- [ ] ステータス別表示
- [ ] 空リストの適切な表示

## 📝 技術仕様
- コマンド形式: @todobot list
- 応答形式: \"📝 TODO一覧\\n1. [タスク1] [ステータス]\\n2. [タスク2] [ステータス]\"

## ✅ 完了条件
- [ ] 一覧表示機能が動作
- [ ] 適切なフォーマットで表示
- [ ] 空リスト時の対応完了" \
  --label "feature,priority-high,component-slack" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[FEATURE] TODO完了機能実装 (@todobot done)" \
  --body "## 📋 機能概要
TODOの完了マーク機能

## 🎯 実装内容
- [ ] TODO状態更新API実装
- [ ] ID指定による操作
- [ ] 完了確認メッセージ
- [ ] 存在しないID時のエラーハンドリング
- [ ] 既に完了済みの場合の処理

## 📝 技術仕様
- コマンド形式: @todobot done [ID]
- 応答: \"✅ TODO「[タスク内容]」を完了にしました\"

## ✅ 完了条件
- [ ] 完了機能が動作
- [ ] 適切なエラーハンドリング
- [ ] 確認メッセージ表示" \
  --label "feature,priority-medium,component-slack" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[FEATURE] TODO削除機能実装 (@todobot delete)" \
  --body "## 📋 機能概要
TODOの削除機能

## 🎯 実装内容
- [ ] TODO削除API実装
- [ ] ID指定による操作
- [ ] 削除確認メッセージ
- [ ] 存在しないID時のエラーハンドリング
- [ ] 安全な削除処理

## 📝 技術仕様
- コマンド形式: @todobot delete [ID]
- 応答: \"🗑️ TODO「[タスク内容]」を削除しました\"

## ✅ 完了条件
- [ ] 削除機能が動作
- [ ] 適切なエラーハンドリング
- [ ] 確認メッセージ表示" \
  --label "feature,priority-medium,component-slack" \
  --milestone "$MILESTONE_1"

echo "  Week 3: Azure デプロイ・CI/CD・監視設定"

gh issue create \
  --title "[INFRA] Dockerファイル作成とコンテナ化" \
  --body "## 🏗️ インフラタスク概要
アプリケーションのDocker化

## 🎯 作業内容
- [ ] Dockerfile作成
- [ ] .dockerignore設定
- [ ] マルチステージビルド対応
- [ ] ローカルコンテナテスト
- [ ] セキュリティベストプラクティス適用

## 🔧 設定ファイル
- [ ] Dockerfile
- [ ] .dockerignore
- [ ] docker-compose.yml (開発用)

## ✅ 完了条件
- [ ] Dockerイメージビルド成功
- [ ] ローカル環境でコンテナ動作確認
- [ ] イメージサイズ最適化完了" \
  --label "infrastructure,priority-high,component-azure" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[INFRA] Azure Container Registry設定" \
  --body "## 🏗️ インフラタスク概要
Container Registryの設定とイメージ管理

## 🎯 作業内容
- [ ] Container Registry作成
- [ ] 認証設定
- [ ] イメージプッシュテスト
- [ ] タグ管理戦略設定
- [ ] セキュリティ設定

## 📊 Azure リソース
- **リソースグループ**: rg-todo-slackapp
- **サービス**: Azure Container Registry
- **SKU**: Basic

## ✅ 完了条件
- [ ] Container Registry作成完了
- [ ] イメージプッシュ・プル確認
- [ ] 認証設定完了" \
  --label "infrastructure,priority-high,component-azure" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[INFRA] Container Apps デプロイ設定" \
  --body "## 🏗️ インフラタスク概要
Container Appsのデプロイ設定

## 🎯 作業内容
- [ ] Container Apps作成
- [ ] 環境変数設定
- [ ] スケーリング設定
- [ ] ネットワーク設定
- [ ] ヘルスチェック設定

## 📊 Azure リソース
- **サービス**: Azure Container Apps
- **プラン**: 消費プラン
- **スケール**: 0-10インスタンス

## ✅ 完了条件
- [ ] Container Apps作成完了
- [ ] アプリケーションデプロイ成功
- [ ] スケーリング動作確認" \
  --label "infrastructure,priority-high,component-azure" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[INFRA] GitHub Actions CI/CD パイプライン構築" \
  --body "## 🏗️ インフラタスク概要
GitHub ActionsによるCI/CDパイプライン構築

## 🎯 作業内容
- [ ] GitHub Actions workflow作成
- [ ] Azure認証設定 (OIDC)
- [ ] 自動ビルド設定
- [ ] 自動デプロイ設定
- [ ] テスト実行設定

## 🔧 設定ファイル
- [ ] .github/workflows/ci-cd.yml
- [ ] Azure OIDC設定
- [ ] シークレット管理

## ✅ 完了条件
- [ ] CI/CDパイプライン動作確認
- [ ] 自動デプロイ成功
- [ ] セキュリティ設定完了" \
  --label "infrastructure,priority-high,component-azure" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[INFRA] Application Insights 監視設定" \
  --body "## 🏗️ インフラタスク概要
Application Insightsによる監視・ログ設定

## 🎯 作業内容
- [ ] Application Insights作成
- [ ] ログ設定
- [ ] メトリクス設定
- [ ] アラート設定
- [ ] ダッシュボード作成

## 📊 Azure リソース
- **サービス**: Application Insights
- **ログレベル**: Info以上
- **アラート**: エラー率・応答時間

## ✅ 完了条件
- [ ] 監視設定完了
- [ ] ログ収集確認
- [ ] アラート動作確認" \
  --label "infrastructure,priority-medium,component-azure" \
  --milestone "$MILESTONE_1"

echo "  Week 4: テスト・本番リリース・ドキュメント"

gh issue create \
  --title "[TEST] 統合テスト実装" \
  --body "## 📋 テスト概要
統合テストの実装

## 🎯 実装内容
- [ ] API統合テスト
- [ ] Slack Bot動作テスト
- [ ] エラーハンドリング確認
- [ ] パフォーマンステスト
- [ ] セキュリティテスト

## ✅ 完了条件
- [ ] 全機能のテスト完了
- [ ] CI/CDでのテスト自動実行
- [ ] テストカバレッジ80%以上" \
  --label "test,priority-high" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[DOCS] API仕様書作成" \
  --body "## 📚 ドキュメント概要
API仕様書の作成

## 🎯 作成・更新内容
- [ ] REST API仕様書
- [ ] Slack コマンド仕様
- [ ] エラーレスポンス仕様
- [ ] 認証仕様
- [ ] レート制限仕様

## 📝 対象ドキュメント
- [ ] docs/api-specification.md

## ✅ 完了条件
- [ ] API仕様書作成完了
- [ ] 実装との整合性確認
- [ ] レビュー完了" \
  --label "documentation,priority-medium" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[DOCS] デプロイメント・運用ガイド作成" \
  --body "## 📚 ドキュメント概要
デプロイメント・運用ガイドの作成

## 🎯 作成・更新内容
- [ ] セットアップガイド
- [ ] 運用マニュアル
- [ ] トラブルシューティングガイド
- [ ] 監視・アラート設定
- [ ] バックアップ・復旧手順

## 📝 対象ドキュメント
- [ ] docs/deployment-guide.md
- [ ] docs/operations-manual.md
- [ ] docs/troubleshooting-guide.md

## ✅ 完了条件
- [ ] 全ドキュメント作成完了
- [ ] 手順の動作確認
- [ ] レビュー完了" \
  --label "documentation,priority-medium" \
  --milestone "$MILESTONE_1"

gh issue create \
  --title "[DOCS] ユーザーガイド作成" \
  --body "## 📚 ドキュメント概要
エンドユーザー向けガイドの作成

## 🎯 作成・更新内容
- [ ] Slack Bot使用方法
- [ ] コマンド一覧
- [ ] FAQ
- [ ] トラブルシューティング（ユーザー向け）
- [ ] 利用規約・注意事項

## 👥 対象読者
- [ ] エンドユーザー
- [ ] Slackワークスペース管理者

## 📝 対象ドキュメント
- [ ] docs/user-guide.md
- [ ] docs/slack-setup-guide.md

## ✅ 完了条件
- [ ] ユーザーガイド作成完了
- [ ] 実際のユーザーテスト完了
- [ ] レビュー完了" \
  --label "documentation,priority-low" \
  --milestone "$MILESTONE_1"

echo "📋 Phase 2 Issues"

gh issue create \
  --title "[FEATURE] TODO期限設定機能" \
  --body "## 📋 機能概要
TODOに期限を設定する機能

## 🎯 実装内容
- [ ] 期限設定API実装
- [ ] 期限付きTODO作成コマンド
- [ ] 期限表示機能
- [ ] 期限ソート機能
- [ ] 期限過ぎTODOの表示

## 📝 技術仕様
- コマンド形式: @todobot add [内容] due:[YYYY-MM-DD]
- データモデル拡張: dueDate フィールド追加

## ✅ 完了条件
- [ ] 期限設定機能が動作
- [ ] 期限表示が適切に動作
- [ ] バリデーション完了" \
  --label "feature,priority-medium,component-slack" \
  --milestone "$MILESTONE_2"

gh issue create \
  --title "[FEATURE] 期限通知機能" \
  --body "## 📋 機能概要
期限が近いTODOの自動通知機能

## 🎯 実装内容
- [ ] 期限チェック機能
- [ ] 通知スケジュール設定
- [ ] Slack通知機能
- [ ] 通知設定管理
- [ ] 通知履歴管理

## 📝 技術仕様
- 通知タイミング: 期限1日前、当日
- 通知方法: Slackチャンネル投稿
- スケジュール: 毎日朝9時実行

## ✅ 完了条件
- [ ] 通知機能が動作
- [ ] スケジュール実行確認
- [ ] 通知設定管理完了" \
  --label "feature,priority-medium,component-slack" \
  --milestone "$MILESTONE_2"

gh issue create \
  --title "[FEATURE] 定期タスク機能" \
  --body "## 📋 機能概要
定期的に繰り返すタスクの管理機能

## 🎯 実装内容
- [ ] 定期タスク設定API
- [ ] 繰り返しパターン設定
- [ ] 自動タスク生成機能
- [ ] 定期タスク管理機能
- [ ] 定期タスク停止・再開機能

## 📝 技術仕様
- 繰り返しパターン: 毎日、毎週、毎月
- コマンド形式: @todobot add-recurring [内容] [パターン]
- データモデル拡張: recurring フィールド追加

## ✅ 完了条件
- [ ] 定期タスク機能が動作
- [ ] 自動生成確認
- [ ] 管理機能完了" \
  --label "feature,priority-low,component-slack" \
  --milestone "$MILESTONE_2"

echo ""
echo "🎉 すべてのマイルストーンとIssues作成完了！"
echo ""
echo "📊 作成されたもの:"
echo "  📋 マイルストーン: 2個"
echo "  🎫 Issues: 20個"
echo "    - Phase 1 (MVP開発): 17個"
echo "    - Phase 2 (機能拡張): 3個"
echo ""
echo "🔗 確認URL:"
echo "  Milestones: https://github.com/hondouchi/todo_slackapp/milestones"
echo "  Issues: https://github.com/hondouchi/todo_slackapp/issues"
