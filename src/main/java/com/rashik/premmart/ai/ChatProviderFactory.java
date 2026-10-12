package com.rashik.premmart.ai;

/**
 * Factory pattern creating the active ChatProvider instance based on configuration.
 */
public final class ChatProviderFactory {

    private ChatProviderFactory() {
    }

    public static ChatProvider getProvider() {
        String provider = System.getenv("AI_CHATBOT_PROVIDER");
        if (provider == null || provider.isBlank()) {
            provider = System.getProperty("ai.chatbot.provider", "gemini");
        }

        if ("mock".equalsIgnoreCase(provider.trim())) {
            return new MockChatProvider();
        }
        return new GeminiChatProvider();
    }
}
