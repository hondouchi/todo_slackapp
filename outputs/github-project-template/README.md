# GitHub Project Setup Template

GitHub プロジェクトの初期セットアップを自動化するためのテンプレートシステムです。プロジェクト作成、Issues、ラベル、マイルストーンの設定を一括で行えます。

## 📁 構成

```
github-project-template/
├── config/
│   └── project-config.yml     # プロジェクト設定ファイル
├── scripts/
│   └── setup-github-project.sh # セットアップスクリプト
├── .github/
│   └── ISSUE_TEMPLATE/         # Issue テンプレート
│       ├── feature.md
│       ├── bug_report.md
│       ├── infrastructure.md
│       └── documentation.md
└── README.md                   # このファイル
```

## 🚀 使用方法

### 1. 事前準備

#### 必要なツールのインストール

```bash
# GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# yq (YAML parser)
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod +x /usr/local/bin/yq
```

#### GitHub CLI 認証

```bash
gh auth login
```

### 2. プロジェクト設定ファイルのカスタマイズ

`config/project-config.yml` をコピーして、新しいプロジェクト用に編集してください。

```bash
# テンプレートをコピー
cp -r github-project-template my-new-project-setup
cd my-new-project-setup

# 設定ファイルを編集
vim config/project-config.yml
```

#### 設定ファイルの主要セクション

- **project**: プロジェクト基本情報（名前、説明、公開設定）
- **milestones**: マイルストーン定義（名前、説明、期日）
- **labels**: ラベル定義（名前、色、説明）
- **custom_fields**: プロジェクトボードのカスタムフィールド
- **issues**: 作成する Issue 一覧

### 3. セットアップ実行

```bash
# スクリプトに実行権限を付与
chmod +x scripts/setup-github-project.sh

# セットアップ実行
./scripts/setup-github-project.sh
```

### 4. セットアップ内容

スクリプトは以下の処理を自動実行します：

1. **ラベル作成**: カテゴリ別のラベルを作成
2. **マイルストーン作成**: プロジェクトの期間を区切るマイルストーンを作成
3. **GitHub プロジェクト作成**: Projects V2 でプロジェクトボードを作成
4. **カスタムフィールド追加**: 優先度、ステータス、担当者フィールドを追加
5. **Issue 作成**: 設定ファイルに定義された Issue を一括作成
6. **プロジェクトへの Issue 追加**: 作成した Issue をプロジェクトボードに登録

## ⚙️ 設定例

### 基本的な Web アプリケーションプロジェクト

```yaml
project:
  name: 'My Web App'
  description: '新しいWebアプリケーションの開発プロジェクト'
  public: false

milestones:
  - name: 'MVP リリース'
    description: '最小限の機能でのリリース'
    due_date: '2024-12-31'
  - name: 'フル機能リリース'
    description: '全機能実装完了'
    due_date: '2025-03-31'

issues:
  - title: 'プロジェクト環境構築'
    body: '開発環境のセットアップを行う'
    labels: ['infrastructure', 'setup']
    milestone: 'MVP リリース'
```

### 機械学習プロジェクト

```yaml
project:
  name: 'ML Model Development'
  description: '機械学習モデルの開発・運用プロジェクト'

labels:
  - name: 'data-science'
    color: '8e44ad'
    description: 'データサイエンス関連'
  - name: 'model-training'
    color: 'e74c3c'
    description: 'モデル学習'
  - name: 'mlops'
    color: '34495e'
    description: 'MLOps・運用'

issues:
  - title: 'データ前処理パイプライン構築'
    body: 'データの前処理・特徴量エンジニアリングのパイプラインを構築'
    labels: ['data-science', 'pipeline']
```

## 🎛️ カスタマイズ

### Issue テンプレートの追加

`.github/ISSUE_TEMPLATE/` に新しいテンプレートを追加できます：

```markdown
---
name: カスタムテンプレート
about: カスタムタスク用テンプレート
title: '[CUSTOM] '
labels: ['custom']
assignees: []
---

## 概要

<!-- タスクの概要 -->
```

### ラベルカテゴリの追加

設定ファイルに新しいラベルカテゴリを追加：

```yaml
labels:
  - name: 'api'
    color: 'ff6b6b'
    description: 'API開発関連'
  - name: 'database'
    color: '4ecdc4'
    description: 'データベース関連'
```

### カスタムフィールドの変更

プロジェクトボードのフィールドをカスタマイズ：

```yaml
custom_fields:
  - name: '開発ステージ'
    type: 'single_select'
    options:
      - '計画'
      - '設計'
      - '実装'
      - 'テスト'
      - '完了'
```

## 🔧 トラブルシューティング

### よくある問題

1. **GitHub CLI 認証エラー**

   ```bash
   gh auth status  # 認証状態確認
   gh auth login   # 再認証
   ```

2. **yq コマンドが見つからない**

   ```bash
   which yq  # yq の確認
   # インストールが必要な場合は上記の手順を実行
   ```

3. **プロジェクト作成権限エラー**

   - GitHub アカウントでプロジェクト作成権限があることを確認
   - Organization の場合は適切な権限が必要

4. **Issue 作成の重複エラー**
   - 既存の Issue と同じタイトルの場合、スクリプトがスキップ
   - ログを確認して重複を避ける

### ログの確認

セットアップ中に問題が発生した場合、詳細なログが出力されます：

```bash
./scripts/setup-github-project.sh 2>&1 | tee setup.log
```

## 📊 成果物

セットアップ完了後、以下が作成されます：

- ✅ GitHub プロジェクト（Projects V2）
- ✅ カテゴリ別ラベル
- ✅ プロジェクトマイルストーン
- ✅ カスタムフィールド付きプロジェクトボード
- ✅ 構造化された Issue（プロジェクトに自動追加）

## 🔄 更新・メンテナンス

### テンプレートの更新

1. 設定ファイルを編集
2. 差分のみ適用する場合は、該当部分のスクリプトを個別実行
3. 新しいプロジェクトには更新されたテンプレートを使用

### Issue の追加

既存プロジェクトに新しい Issue を追加：

```bash
# 設定ファイルに新しいIssueを追加後
./scripts/setup-github-project.sh --issues-only
```

## 📝 ライセンス

MIT License

## 🤝 コントリビューション

改善提案やバグ報告は Issue または Pull Request でお願いします。
