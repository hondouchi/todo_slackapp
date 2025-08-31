import dotenv from 'dotenv';

// 環境変数の読み込み
dotenv.config();

export interface SlackConfig {
  botToken: string;
  signingSecret: string;
  appToken: string | undefined;
  port: number;
}

export interface AppConfig {
  slack: SlackConfig;
  environment: 'development' | 'production' | 'test';
}

/**
 * 環境変数から設定を読み込み
 */
export const getConfig = (): AppConfig => {
  const slack: SlackConfig = {
    botToken: process.env.SLACK_BOT_TOKEN || '',
    signingSecret: process.env.SLACK_SIGNING_SECRET || '',
    appToken: process.env.SLACK_APP_TOKEN,
    port: parseInt(process.env.PORT || '3000', 10),
  };

  // 必須環境変数のチェック
  if (!slack.botToken) {
    throw new Error('SLACK_BOT_TOKEN is required');
  }

  if (!slack.signingSecret) {
    throw new Error('SLACK_SIGNING_SECRET is required');
  }

  return {
    slack,
    environment: (process.env.NODE_ENV as 'development' | 'production' | 'test') || 'development',
  };
};
