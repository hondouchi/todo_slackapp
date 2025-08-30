# Project Management - GitHub Issues & Milestones

このファイルは、todo_slackapp プロジェクトのGitHub Issues管理用のガイドです。

## 📋 マイルストーン構成

### Phase 1: MVP開発 (4週間)
- **期間**: 4週間
- **目標**: 基本的なSlack Bot TODO機能の実装とデプロイ

### Phase 2: 機能拡張 (2週間)
- **期間**: 2週間  
- **目標**: 期限設定・通知・レポート機能追加

## 🏷️ ラベル体系

### 種類別
- `feature` - 新機能開発
- `bug` - バグ修正
- `infrastructure` - インフラ・DevOps
- `documentation` - ドキュメント
- `test` - テスト関連

### 優先度別  
- `priority-high` - 高優先度
- `priority-medium` - 中優先度
- `priority-low` - 低優先度

### ステータス別
- `status-planning` - 計画中
- `status-in-progress` - 作業中
- `status-review` - レビュー中
- `status-blocked` - ブロック中

### コンポーネント別
- `component-slack` - Slack関連
- `component-azure` - Azure関連
- `component-api` - API関連
- `component-ui` - UI関連

## 📊 Issue作成ガイドライン

### 1. 適切なテンプレートを使用
- 機能開発: `feature.md`
- バグ修正: `bug_report.md`
- インフラ: `infrastructure.md`
- ドキュメント: `documentation.md`

### 2. 明確なタイトル
- `[FEATURE] Slack Bot基本機能実装`
- `[INFRA] Azure Container Apps環境構築`
- `[DOCS] API仕様書作成`

### 3. 適切なラベル付け
- 種類 + 優先度 + コンポーネント
- 例: `feature`, `priority-high`, `component-slack`

### 4. マイルストーンの割り当て
- すべてのIssueは適切なマイルストーンに割り当て

## 🔄 ワークフロー

1. **Issue作成** → テンプレート使用
2. **ラベル付け** → 種類・優先度・コンポーネント
3. **マイルストーン割り当て** → Phase 1 or Phase 2
4. **作業開始** → `status-in-progress`ラベル
5. **プルリクエスト** → Issue番号を記載
6. **レビュー** → `status-review`ラベル
7. **マージ・クローズ** → Issueクローズ

## 📈 進捗管理

### GitHub Projects (推奨)
- Kanbanボード形式での進捗可視化
- Milestone別のビュー
- 優先度別のフィルタリング

### Issue一覧での管理
- マイルストーン別での確認
- ラベルフィルタでの絞り込み
- アサイン状況の確認

---
**管理者**: hondouchi  
**最終更新**: 2025年8月30日
