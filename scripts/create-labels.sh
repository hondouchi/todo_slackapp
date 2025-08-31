#!/bin/bash

# GitHub Labels 作成スクリプト
# Usage: bash scripts/create-labels.sh

set -e

echo "🏷️ GitHub ラベル作成開始..."

# 種類別ラベル
echo "Creating category labels..."
gh label create "feature" --description "新機能開発" --color "0366d6" || echo "Label 'feature' already exists"
gh label create "bug" --description "バグ修正" --color "d73a4a" || echo "Label 'bug' already exists"
gh label create "infrastructure" --description "インフラ・DevOps" --color "f9d71c" || echo "Label 'infrastructure' already exists"
gh label create "documentation" --description "ドキュメント" --color "0052cc" || echo "Label 'documentation' already exists"
gh label create "test" --description "テスト関連" --color "d4c5f9" || echo "Label 'test' already exists"

# 優先度別ラベル
echo "Creating priority labels..."
gh label create "priority-high" --description "高優先度" --color "b60205" || echo "Label 'priority-high' already exists"
gh label create "priority-medium" --description "中優先度" --color "fbca04" || echo "Label 'priority-medium' already exists"
gh label create "priority-low" --description "低優先度" --color "0e8a16" || echo "Label 'priority-low' already exists"

# ステータス別ラベル
echo "Creating status labels..."
gh label create "status-planning" --description "計画中" --color "c5def5" || echo "Label 'status-planning' already exists"
gh label create "status-in-progress" --description "作業中" --color "1d76db" || echo "Label 'status-in-progress' already exists"
gh label create "status-review" --description "レビュー中" --color "0052cc" || echo "Label 'status-review' already exists"
gh label create "status-blocked" --description "ブロック中" --color "d93f0b" || echo "Label 'status-blocked' already exists"

# コンポーネント別ラベル
echo "Creating component labels..."
gh label create "component-slack" --description "Slack関連" --color "e99695" || echo "Label 'component-slack' already exists"
gh label create "component-azure" --description "Azure関連" --color "0078d4" || echo "Label 'component-azure' already exists"
gh label create "component-api" --description "API関連" --color "5319e7" || echo "Label 'component-api' already exists"
gh label create "component-ui" --description "UI関連" --color "ff6b9d" || echo "Label 'component-ui' already exists"

echo "✅ ラベル作成完了！"
