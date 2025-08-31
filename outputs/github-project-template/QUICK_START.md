# Quick Start Guide

GitHub Project Setup Template の簡単な使用例です。

## 🚀 5 分でできる基本セットアップ

### 1. テンプレートをコピー

```bash
# プロジェクト用のディレクトリを作成
mkdir my-awesome-project-setup
cd my-awesome-project-setup

# テンプレートをコピー（パスは適宜調整）
cp -r /path/to/github-project-template/* .
```

### 2. 基本設定を編集

`config/project-config.yml` の必須項目を編集：

```yaml
project:
  title: 'My Awesome Project'
  description: '素晴らしいプロジェクトの説明'
  owner: 'your-github-username'
  repository: 'my-awesome-project'

milestones:
  - title: 'v1.0 リリース'
    description: '初回リリース'
    due_date: '2024-12-31'

issues:
  - title: 'プロジェクト初期セットアップ'
    body: '開発環境とCI/CDの構築'
    labels: ['infrastructure', 'setup']
    milestone: 'v1.0 リリース'

  - title: 'READMEドキュメント作成'
    body: 'プロジェクトのREADMEを作成'
    labels: ['documentation']
    milestone: 'v1.0 リリース'
```

### 3. セットアップ実行

```bash
# GitHub CLI にログインしていることを確認
gh auth status

# セットアップ実行
./scripts/setup-github-project.sh
```

### 4. 完了！

以下が自動作成されます：

- ✅ GitHub プロジェクト
- ✅ マイルストーン
- ✅ ラベル
- ✅ Issue（プロジェクトに追加済み）

## 📋 セットアップ後の確認事項

1. **GitHub プロジェクト**: `https://github.com/users/your-username/projects/X`
2. **Issues**: リポジトリの Issues タブで確認
3. **マイルストーン**: Issues > Milestones で確認

## 🔄 Issue の追加

後から Issue を追加したい場合：

1. `config/project-config.yml` に Issue を追加
2. `./scripts/setup-github-project.sh --issues-only` を実行

## ⭐ プロジェクト例

### Web アプリケーション

```yaml
project:
  title: 'Todo Web App'
  description: 'React + Node.js のTodoアプリ'

issues:
  - title: 'フロントエンド環境構築'
    body: 'React, TypeScript, Tailwind CSS の環境構築'
    labels: ['frontend', 'setup']

  - title: 'バックエンドAPI設計'
    body: 'REST API の設計と実装'
    labels: ['backend', 'api']
```

### 機械学習プロジェクト

```yaml
project:
  title: 'ML Prediction Model'
  description: '売上予測機械学習モデル'

labels:
  - name: 'data-science'
    color: '8e44ad'
    description: 'データサイエンス'

issues:
  - title: 'データ収集・前処理'
    body: '売上データの収集と前処理パイプライン構築'
    labels: ['data-science', 'preprocessing']
```

## 🛠️ カスタマイズのヒント

- **ラベル色**: [GitHub Label Colors](https://github.com/pvdlg/conventional-changelog-metahub/blob/master/lib/default-label-colors.json) を参考
- **Issue テンプレート**: `.github/ISSUE_TEMPLATE/` で自由にカスタマイズ
- **カスタムフィールド**: プロジェクトボードに追加のフィールドを設定可能

Happy Coding! 🎉
