package org.chatpoc.back.dto;

import lombok.Data;

@Data
public class ChatMessage {

    private String sender;
    private String content;
}