package org.chatpoc.back.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ChatMessage {

    private String from;
    private String message;
}
