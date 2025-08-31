#!/bin/bash

# GitHub Project 作成とIssue自動登録スクリプト
# Usage: bash scripts/create-project.sh

set -e

echo "📊 GitHub Project 作成とIssue自動登録開始..."

# プロジェクト作成
echo "🔨 GitHub Project 作成中..."
PROJECT_URL=$(gh project create --owner hondouchi --title "Slack Bot TODO App" --format=json | jq -r '.url')

echo "✅ GitHub Project作成完了!"
echo "🔗 Project URL: $PROJECT_URL"

# Project番号を抽出
PROJECT_NUMBER=$(echo $PROJECT_URL | sed 's/.*\/projects\///')
echo "📊 Project番号: $PROJECT_NUMBER"

echo ""
echo "📝 カスタムフィールド作成中..."

# 優先度フィールド作成
gh project field-create $PROJECT_NUMBER --owner hondouchi --name "Priority" --data-type "SINGLE_SELECT" --single-select-options "🔴 High,🟡 Medium,🟢 Low"

# フェーズフィールド作成  
gh project field-create $PROJECT_NUMBER --owner hondouchi --name "Phase" --data-type "SINGLE_SELECT" --single-select-options "Phase 1: MVP,Phase 2: 機能拡張"

# 作業週フィールド作成
gh project field-create $PROJECT_NUMBER --owner hondouchi --name "Week" --data-type "SINGLE_SELECT" --single-select-options "Week 1,Week 2,Week 3,Week 4"

echo "✅ カスタムフィールド作成完了!"

echo ""
echo "🎫 既存Issues をProject に追加中..."

# Phase 1 Issues追加 (Issue #2-18)
echo "  Phase 1 Issues追加中..."
for issue_number in {2..18}; do
    echo "    Adding Issue #$issue_number..."
    gh project item-add $PROJECT_NUMBER --owner hondouchi --url "https://github.com/hondouchi/todo_slackapp/issues/$issue_number"
done

# Phase 2 Issues追加 (Issue #19-21)  
echo "  Phase 2 Issues追加中..."
for issue_number in {19..21}; do
    echo "    Adding Issue #$issue_number..."
    gh project item-add $PROJECT_NUMBER --owner hondouchi --url "https://github.com/hondouchi/todo_slackapp/issues/$issue_number"
done

echo ""
echo "🎉 GitHub Project作成とIssue登録完了！"
echo ""
echo "📊 作成されたもの:"
echo "  📋 GitHub Project: Slack Bot TODO App"
echo "  🎫 登録Issues: 20個 (Issue #2-21)"
echo "  🏷️ カスタムフィールド: Priority, Phase, Week"
echo ""
echo "🔗 確認URL:"
echo "  Project: $PROJECT_URL"
echo "  Issues: https://github.com/hondouchi/todo_slackapp/issues"
echo ""
echo "📝 次のステップ:"
echo "  1. Projectビューのカスタマイズ (Board/Table)"  
echo "  2. 各IssueのPriority・Phase・Week設定"
echo "  3. 自動化ルールの設定 (オプション)"
