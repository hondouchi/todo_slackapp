import { App, LogLevel } from '@slack/bolt';
import { getConfig } from '../config/app';

export class SlackBot {
  private app: App;
  private config = getConfig();

  constructor() {
    const appConfig: any = {
      token: this.config.slack.botToken,
      signingSecret: this.config.slack.signingSecret,
      logLevel: this.config.environment === 'development' ? LogLevel.DEBUG : LogLevel.INFO,
    };

    // Socket Mode用の設定（開発時）
    if (this.config.slack.appToken) {
      appConfig.socketMode = true;
      appConfig.appToken = this.config.slack.appToken;
    }

    this.app = new App(appConfig);
    this.setupEventHandlers();
  }

  /**
   * Slackイベントハンドラーの設定
   */
  private setupEventHandlers(): void {
    // アプリメンションの処理 - 正確なメンションとメッセージの両方に対応
    this.app.event('app_mention', async ({ event, say }) => {
      console.log('[DEBUG] App mention received:', event);
      await this.handleTodoCommand(event, say);
    });

    // メッセージ内にボット名が含まれる場合も処理（後方互換性のため）
    this.app.message(/todo-slack-app|todobot/i, async ({ message, say }) => {
      console.log('[DEBUG] Message with bot name received:', message);
      await this.handleTodoCommand(message, say);
    });

    // アプリがワークスペースに追加された時の処理
    this.app.event('app_home_opened', async ({ say }) => {
      await say(`こんにちは！TODOボットです。\n\`@todo-slack-app help\` でコマンドを確認できます。`);
    });

    // エラーハンドリング
    this.app.error(async (error) => {
      console.error('Slack Bot Error:', error);
    });
  }

  /**
   * TODOコマンドの処理
   */
  private async handleTodoCommand(message: any, say: any): Promise<void> {
    try {
      const text = message.text.toLowerCase();
      
      if (text.includes('help')) {
        await this.showHelp(say);
      } else if (text.includes('add')) {
        await this.addTodo(text, say);
      } else if (text.includes('list')) {
        await this.listTodos(say);
      } else if (text.includes('done')) {
        await this.markTodoAsDone(text, say);
      } else if (text.includes('delete')) {
        await this.deleteTodo(text, say);
      } else {
        await say('コマンドが認識できませんでした。`@todobot help` でヘルプを確認してください。');
      }
    } catch (error) {
      console.error('Error handling todo command:', error);
      await say('エラーが発生しました。しばらく後にもう一度お試しください。');
    }
  }

  /**
   * ヘルプメッセージの表示
   */
  private async showHelp(say: any): Promise<void> {
    const helpMessage = `
🤖 **TODOボット コマンド一覧**

• \`@todobot add [内容]\` - TODOを追加
• \`@todobot list\` - TODO一覧を表示
• \`@todobot done [ID]\` - TODOを完了にマーク
• \`@todobot delete [ID]\` - TODOを削除
• \`@todobot help\` - このヘルプを表示

例: \`@todobot add 会議資料を作成\`
    `;
    
    await say(helpMessage);
  }

  /**
   * TODO追加（仮実装）
   */
  private async addTodo(text: string, say: any): Promise<void> {
    // 'add' 以降のテキストを取得
    const todoContent = text.split('add')[1]?.trim();
    
    if (!todoContent) {
      await say('TODOの内容を入力してください。\n例: `@todobot add 会議資料を作成`');
      return;
    }

    // TODO: 実際のデータベース保存処理は後で実装
    const todoId = Math.floor(Math.random() * 1000); // 仮のID
    
    await say(`✅ TODOを追加しました！\n**ID**: ${todoId}\n**内容**: ${todoContent}`);
  }

  /**
   * TODO一覧表示（仮実装）
   */
  private async listTodos(say: any): Promise<void> {
    // TODO: 実際のデータベース取得処理は後で実装
    const sampleTodos = [
      { id: 1, content: '会議資料を作成', completed: false },
      { id: 2, content: 'コードレビュー', completed: true },
    ];

    if (sampleTodos.length === 0) {
      await say('📝 TODOはありません。');
      return;
    }

    let message = '📋 **TODO一覧**\n\n';
    sampleTodos.forEach(todo => {
      const status = todo.completed ? '✅' : '⏸️';
      message += `${status} **[${todo.id}]** ${todo.content}\n`;
    });

    await say(message);
  }

  /**
   * TODO完了マーク（仮実装）
   */
  private async markTodoAsDone(text: string, say: any): Promise<void> {
    const match = text.match(/done\s+(\d+)/);
    const todoId = match?.[1];

    if (!todoId) {
      await say('TODOのIDを指定してください。\n例: `@todobot done 1`');
      return;
    }

    // TODO: 実際のデータベース更新処理は後で実装
    await say(`✅ TODO [${todoId}] を完了にマークしました！`);
  }

  /**
   * TODO削除（仮実装）
   */
  private async deleteTodo(text: string, say: any): Promise<void> {
    const match = text.match(/delete\s+(\d+)/);
    const todoId = match?.[1];

    if (!todoId) {
      await say('TODOのIDを指定してください。\n例: `@todobot delete 1`');
      return;
    }

    // TODO: 実際のデータベース削除処理は後で実装
    await say(`🗑️ TODO [${todoId}] を削除しました！`);
  }

  /**
   * アプリケーションの起動
   */
  public async start(): Promise<void> {
    try {
      await this.app.start(this.config.slack.port);
      console.log(`⚡ Slack Bot app is running on port ${this.config.slack.port}!`);
    } catch (error) {
      console.error('Failed to start Slack Bot app:', error);
      throw error;
    }
  }

  /**
   * アプリケーションの停止
   */
  public async stop(): Promise<void> {
    await this.app.stop();
    console.log('Slack Bot app stopped.');
  }
}
