# 🏗️ プロジェクト環境構築ガイド

**作成日**: 2025年8月31日  
**対象**: Slack Bot TODO App (Azure Container Apps + Cosmos DB)  
**実行者**: 開発チーム

## 📋 概要

Node.js + TypeScript + Slack Bolt + Azure Cosmos DB を使用したプロジェクトの環境構築手順を記載。

## 🎯 構築目標

- ✅ TypeScript開発環境の構築
- ✅ Slack Boltフレームワークの統合
- ✅ Azure Cosmos DB接続準備
- ✅ コード品質ツール（ESLint, Prettier）の設定
- ✅ テスト環境（Jest）の構築
- ✅ Docker化対応

## 🚀 実行手順

### 1. Node.js プロジェクト初期化

```bash
# プロジェクトディレクトリに移動
cd /path/to/todo_slackapp

# package.jsonの生成
npm init -y
```

**結果**: 基本的なpackage.jsonが生成される

### 2. 依存関係のインストール

#### 本番依存関係

```bash
npm install @slack/bolt @azure/cosmos dotenv
```

#### 開発依存関係

```bash
npm install -D typescript @types/node ts-node nodemon
npm install -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier @types/jest jest
```

**結果**: 必要なパッケージがインストールされ、package.jsonに追加される

### 3. TypeScript設定

#### tsconfig.json の作成・最適化

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "types": ["node", "jest"],
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "strict": true,
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true,
    "noUncheckedIndexedAccess": true,
    "sourceMap": true,
    "declaration": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts", "**/*.spec.ts"]
}
```

### 4. プロジェクト構造の作成

```bash
mkdir -p src/{controllers,services,models,utils,config} tests
```

**ディレクトリ構造**:

```
src/
├── controllers/    # Slackイベント処理
├── services/       # ビジネスロジック
├── models/         # データモデル
├── utils/          # ユーティリティ
├── config/         # 設定ファイル
└── index.ts        # エントリーポイント
tests/              # テストファイル
```

### 5. 基本ファイルの作成

#### src/index.ts (エントリーポイント)

```typescript
// Slack Bot TODO App Entry Point
console.log('Slack Bot TODO App - Starting...');

export {};
```

#### .env.example (環境変数テンプレート)

```bash
# Slack Bot Configuration
SLACK_BOT_TOKEN=xoxb-your-bot-token-here
SLACK_SIGNING_SECRET=your-signing-secret-here
SLACK_APP_TOKEN=xapp-your-app-token-here

# Azure Cosmos DB Configuration
COSMOS_DB_ENDPOINT=https://your-cosmosdb-account.documents.azure.com:443/
COSMOS_DB_KEY=your-cosmos-db-primary-key-here
COSMOS_DB_DATABASE_NAME=todoapp
COSMOS_DB_CONTAINER_NAME=todos

# Application Configuration
PORT=3000
NODE_ENV=development
```

### 6. 開発ツールの設定

#### ESLint設定 (.eslintrc.js)

```javascript
module.exports = {
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 2020,
    sourceType: 'module',
    project: './tsconfig.json',
  },
  plugins: ['@typescript-eslint'],
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
    '@typescript-eslint/recommended-requiring-type-checking',
  ],
  root: true,
  env: { node: true, jest: true },
  ignorePatterns: ['.eslintrc.js', 'dist/**/*'],
  rules: {
    '@typescript-eslint/interface-name-prefix': 'off',
    '@typescript-eslint/explicit-function-return-type': 'warn',
    '@typescript-eslint/explicit-module-boundary-types': 'warn',
    '@typescript-eslint/no-explicit-any': 'error',
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/prefer-const': 'error',
    'no-console': 'warn',
  },
};
```

#### Prettier設定 (.prettierrc)

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
```

#### Jest設定 (jest.config.js)

```javascript
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src', '<rootDir>/tests'],
  testMatch: ['**/__tests__/**/*.ts', '**/?(*.)+(spec|test).ts'],
  transform: { '^.+\\.ts$': 'ts-jest' },
  collectCoverageFrom: ['src/**/*.ts', '!src/**/*.d.ts', '!src/index.ts'],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
};
```

### 7. Docker設定

#### Dockerfile

```dockerfile
# Multi-stage build for production optimization
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine AS production

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

COPY --from=builder /app/dist ./dist

# Security: Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
RUN chown -R nodejs:nodejs /app
USER nodejs

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node dist/health.js || exit 1

CMD ["node", "dist/index.js"]
```

### 8. package.json スクリプトの最適化

```json
{
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "dev": "nodemon --exec ts-node src/index.ts",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src/**/*.ts",
    "lint:fix": "eslint src/**/*.ts --fix",
    "format": "prettier --write src/**/*.ts",
    "clean": "rm -rf dist",
    "prebuild": "npm run clean",
    "docker:build": "docker build -t todo-slackapp .",
    "docker:run": "docker run -p 3000:3000 todo-slackapp"
  }
}
```

## ✅ 動作確認

### 1. TypeScriptビルドテスト

```bash
npm run build
```

**期待結果**: `dist/`ディレクトリにJavaScriptファイルが生成される

### 2. アプリケーション起動テスト

```bash
npm start
```

**期待結果**: "Slack Bot TODO App - Starting..." が表示される

### 3. 開発モードテスト

```bash
npm run dev
```

**期待結果**: nodemonでファイル監視モードで起動

### 4. コード品質チェック

```bash
npm run lint
npm run format
```

### 5. テスト実行

```bash
npm test
```

## 🔧 TIPS & トラブルシューティング

### 💡 成功のポイント

1. **依存関係の順序**: 本番依存関係を先にインストールしてから開発依存関係を追加
2. **TypeScript設定**: プロジェクトに適した厳格な型チェック設定を採用
3. **ディレクトリ構造**: 機能別にディレクトリを分割して保守性を向上
4. **Docker最適化**: マルチステージビルドで本番イメージサイズを最小化

### ⚠️ 注意点・トラブル対処

#### 1. TypeScript設定エラー

**問題**: `構成ファイルで入力が見つかりませんでした`

```bash
# 解決方法
mkdir src
touch src/index.ts
```

#### 2. ESLint設定エラー

**問題**: `Parsing error: Cannot read file '/tsconfig.json'`

```bash
# 解決方法: tsconfig.jsonの存在確認
ls -la tsconfig.json
# または相対パスを修正
"project": "./tsconfig.json"
```

#### 3. npm脆弱性警告

**問題**: `found 0 vulnerabilities` でも警告が出る場合

```bash
# 解決方法: 監査と自動修正
npm audit
npm audit fix
```

#### 4. Node.js バージョン問題

**問題**: TypeScriptビルドエラー

```bash
# 解決方法: Node.js バージョン確認
node --version  # v18+ を推奨
nvm use 18     # nvmを使用している場合
```

#### 5. Dockerビルドエラー

**問題**: multi-stage buildでコピーエラー

```bash
# 解決方法: .dockerignoreファイル作成
echo "node_modules" > .dockerignore
echo "dist" >> .dockerignore
echo ".git" >> .dockerignore
```

### 📊 パフォーマンス最適化

1. **TypeScript**: `skipLibCheck: true` で型チェック高速化
2. **Docker**: Alpine Linuxベースで軽量化
3. **npm**: `npm ci` で高速で確実なインストール
4. **ESLint**: 不要なルールを無効化してリント時間短縮

## 📋 チェックリスト

- [ ] Node.js 18+ がインストール済み
- [ ] npm 依存関係のインストール完了
- [ ] TypeScript ビルドが成功
- [ ] src/index.ts からアプリケーション起動確認
- [ ] ESLint でコード品質チェック通過
- [ ] Prettier でコードフォーマット適用
- [ ] Jest でテスト環境確認
- [ ] Docker ビルドが成功
- [ ] 環境変数テンプレート (.env.example) 作成済み
- [ ] .gitignore 設定済み

## 🎯 次のステップ

環境構築完了後、以下の順序で開発を進める：

1. **🤖 基本Slack Bot実装** - Slack Bolt アプリの基本機能
2. **💾 Cosmos DB接続実装** - データ永続化レイヤー
3. **🔧 TODO CRUD機能実装** - 核となるビジネスロジック
4. **🧪 テスト実装** - 自動テストの追加
5. **☁️ Azure デプロイ** - Container Apps へのデプロイ

---

**📝 注記**: このドキュメントは実際の構築過程で得られた知見を基に作成されており、同様の環境で再現可能な手順として検証済みです。
