#!/bin/bash

# GitHub Project 汎用セットアップスクリプト
# Usage: bash scripts/setup-github-project.sh [config-file]
# Example: bash scripts/setup-github-project.sh config/project-config.yml

set -e

# 設定ファイルのパスを取得
CONFIG_FILE=${1:-"config/project-config.yml"}

# 設定ファイルの存在確認
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 設定ファイルが見つかりません: $CONFIG_FILE"
    echo "📝 config/project-config.yml を編集してから実行してください"
    exit 1
fi

echo "🚀 GitHub Project セットアップ開始..."
echo "📋 設定ファイル: $CONFIG_FILE"
echo ""

# yqコマンドの確認
if ! command -v yq &> /dev/null; then
    echo "❌ yq コマンドが見つかりません"
    echo "📥 インストール方法:"
    echo "  # Ubuntu/Debian"
    echo "  sudo apt install yq"
    echo "  # macOS"
    echo "  brew install yq"
    exit 1
fi

# 設定値を読み込む
PROJECT_TITLE=$(yq e '.project.title' $CONFIG_FILE)
PROJECT_OWNER=$(yq e '.project.owner' $CONFIG_FILE)
PROJECT_REPO=$(yq e '.project.repository' $CONFIG_FILE)
PROJECT_DESC=$(yq e '.project.description' $CONFIG_FILE)

echo "📊 プロジェクト情報:"
echo "  タイトル: $PROJECT_TITLE"
echo "  オーナー: $PROJECT_OWNER"
echo "  リポジトリ: $PROJECT_REPO"
echo ""

# GitHub CLI認証確認
if ! gh auth status &> /dev/null; then
    echo "❌ GitHub CLI認証が必要です"
    echo "🔐 以下のコマンドで認証してください:"
    echo "  gh auth login"
    exit 1
fi

echo "✅ GitHub CLI認証確認済み"
echo ""

# ラベル作成
echo "🏷️ ラベル作成中..."

# 種類別ラベル
yq e '.labels.categories[]' $CONFIG_FILE | while read -r label; do
    name=$(echo "$label" | yq e '.name')
    desc=$(echo "$label" | yq e '.description')
    color=$(echo "$label" | yq e '.color')
    
    if [ "$name" != "null" ] && [ "$desc" != "null" ] && [ "$color" != "null" ]; then
        echo "  Creating label: $name"
        gh label create "$name" --description "$desc" --color "$color" --repo "$PROJECT_OWNER/$PROJECT_REPO" || echo "    Label '$name' already exists"
    fi
done

# 優先度別ラベル
yq e '.labels.priorities[]' $CONFIG_FILE | while read -r label; do
    name=$(echo "$label" | yq e '.name')
    desc=$(echo "$label" | yq e '.description')
    color=$(echo "$label" | yq e '.color')
    
    if [ "$name" != "null" ] && [ "$desc" != "null" ] && [ "$color" != "null" ]; then
        echo "  Creating label: $name"
        gh label create "$name" --description "$desc" --color "$color" --repo "$PROJECT_OWNER/$PROJECT_REPO" || echo "    Label '$name' already exists"
    fi
done

# ステータス別ラベル
yq e '.labels.statuses[]' $CONFIG_FILE | while read -r label; do
    name=$(echo "$label" | yq e '.name')
    desc=$(echo "$label" | yq e '.description')
    color=$(echo "$label" | yq e '.color')
    
    if [ "$name" != "null" ] && [ "$desc" != "null" ] && [ "$color" != "null" ]; then
        echo "  Creating label: $name"
        gh label create "$name" --description "$desc" --color "$color" --repo "$PROJECT_OWNER/$PROJECT_REPO" || echo "    Label '$name' already exists"
    fi
done

# カスタムラベル
yq e '.labels.custom[]' $CONFIG_FILE | while read -r label; do
    name=$(echo "$label" | yq e '.name')
    desc=$(echo "$label" | yq e '.description')
    color=$(echo "$label" | yq e '.color')
    
    if [ "$name" != "null" ] && [ "$desc" != "null" ] && [ "$color" != "null" ]; then
        echo "  Creating label: $name"
        gh label create "$name" --description "$desc" --color "$color" --repo "$PROJECT_OWNER/$PROJECT_REPO" || echo "    Label '$name' already exists"
    fi
done

echo "✅ ラベル作成完了"
echo ""

# マイルストーン作成
echo "📋 マイルストーン作成中..."

yq e '.milestones[]' $CONFIG_FILE | while read -r milestone; do
    title=$(echo "$milestone" | yq e '.title')
    desc=$(echo "$milestone" | yq e '.description')
    due_date=$(echo "$milestone" | yq e '.due_date')
    
    if [ "$title" != "null" ] && [ "$desc" != "null" ]; then
        echo "  Creating milestone: $title"
        if [ "$due_date" != "null" ]; then
            gh api repos/$PROJECT_OWNER/$PROJECT_REPO/milestones \
                --method POST \
                --field title="$title" \
                --field description="$desc" \
                --field due_on="${due_date}T23:59:59Z" \
                --field state="open" > /dev/null || echo "    Milestone '$title' may already exist"
        else
            gh api repos/$PROJECT_OWNER/$PROJECT_REPO/milestones \
                --method POST \
                --field title="$title" \
                --field description="$desc" \
                --field state="open" > /dev/null || echo "    Milestone '$title' may already exist"
        fi
    fi
done

echo "✅ マイルストーン作成完了"
echo ""

# GitHub Project作成
echo "📊 GitHub Project作成中..."

PROJECT_URL=$(gh project create --owner $PROJECT_OWNER --title "$PROJECT_TITLE" --format=json | jq -r '.url')
PROJECT_NUMBER=$(echo $PROJECT_URL | sed 's/.*\/projects\///')

echo "✅ GitHub Project作成完了!"
echo "🔗 Project URL: $PROJECT_URL"
echo "📊 Project番号: $PROJECT_NUMBER"
echo ""

# カスタムフィールド作成
echo "🔧 カスタムフィールド作成中..."

yq e '.custom_fields[]' $CONFIG_FILE | while read -r field; do
    name=$(echo "$field" | yq e '.name')
    type=$(echo "$field" | yq e '.type')
    
    if [ "$name" != "null" ] && [ "$type" != "null" ]; then
        echo "  Creating field: $name ($type)"
        
        if [ "$type" = "SINGLE_SELECT" ]; then
            options=$(echo "$field" | yq e '.options[]' | tr '\n' ',' | sed 's/,$//')
            gh project field-create $PROJECT_NUMBER --owner $PROJECT_OWNER --name "$name" --data-type "$type" --single-select-options "$options" > /dev/null
        else
            gh project field-create $PROJECT_NUMBER --owner $PROJECT_OWNER --name "$name" --data-type "$type" > /dev/null
        fi
    fi
done

echo "✅ カスタムフィールド作成完了"
echo ""

# Issues作成
echo "🎫 Issues作成中..."

issue_count=0
yq e '.issues[]' $CONFIG_FILE | while read -r issue; do
    title=$(echo "$issue" | yq e '.title')
    body=$(echo "$issue" | yq e '.body')
    milestone=$(echo "$issue" | yq e '.milestone')
    
    if [ "$title" != "null" ] && [ "$body" != "null" ]; then
        echo "  Creating issue: $title"
        
        # ラベル取得
        labels_array=$(echo "$issue" | yq e '.labels[]' 2>/dev/null | tr '\n' ',' | sed 's/,$//')
        
        # Issue作成
        if [ "$milestone" != "null" ] && [ "$labels_array" != "" ]; then
            issue_url=$(gh issue create --title "$title" --body "$body" --milestone "$milestone" --label "$labels_array" --repo "$PROJECT_OWNER/$PROJECT_REPO")
        elif [ "$milestone" != "null" ]; then
            issue_url=$(gh issue create --title "$title" --body "$body" --milestone "$milestone" --repo "$PROJECT_OWNER/$PROJECT_REPO")
        elif [ "$labels_array" != "" ]; then
            issue_url=$(gh issue create --title "$title" --body "$body" --label "$labels_array" --repo "$PROJECT_OWNER/$PROJECT_REPO")
        else
            issue_url=$(gh issue create --title "$title" --body "$body" --repo "$PROJECT_OWNER/$PROJECT_REPO")
        fi
        
        # ProjectにIssue追加
        gh project item-add $PROJECT_NUMBER --owner $PROJECT_OWNER --url "$issue_url" > /dev/null
        
        issue_count=$((issue_count + 1))
    fi
done

echo "✅ Issues作成完了 ($issue_count個)"
echo ""

echo "🎉 GitHub Project セットアップ完了！"
echo ""
echo "📊 作成されたもの:"
echo "  📋 GitHub Project: $PROJECT_TITLE"
echo "  🏷️ ラベル: 複数個"
echo "  📋 マイルストーン: 複数個"
echo "  🎫 Issues: 複数個"
echo ""
echo "🔗 確認URL:"
echo "  Project: $PROJECT_URL"
echo "  Repository: https://github.com/$PROJECT_OWNER/$PROJECT_REPO"
echo ""
echo "📝 次のステップ:"
echo "  1. Projectビューのカスタマイズ"
echo "  2. 各IssueのカスタムフィールドView設定"
echo "  3. 自動化ルールの設定（オプション）"
