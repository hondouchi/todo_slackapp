import { SlackBot } from './services/slackBot';

/**
 * Slack Bot TODO App Entry Point
 */
async function main(): Promise<void> {
  console.log('🚀 Slack Bot TODO App - Starting...');

  try {
    const slackBot = new SlackBot();
    await slackBot.start();
    
    console.log('✅ Slack Bot TODO App started successfully!');
    
    // Graceful shutdown handling
    process.on('SIGINT', async () => {
      console.log('\n🛑 Shutting down gracefully...');
      await slackBot.stop();
      process.exit(0);
    });

    process.on('SIGTERM', async () => {
      console.log('\n🛑 Shutting down gracefully...');
      await slackBot.stop();
      process.exit(0);
    });

  } catch (error) {
    console.error('❌ Failed to start Slack Bot:', error);
    process.exit(1);
  }
}

// アプリケーション開始
main().catch((error) => {
  console.error('❌ Unhandled error:', error);
  process.exit(1);
});
