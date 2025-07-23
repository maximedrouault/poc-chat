package org.chatpoc.back.controller;

import lombok.extern.log4j.Log4j2;
import org.chatpoc.back.dto.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
@Log4j2
public class ChatController {

    @MessageMapping("/chat.send")
    @SendTo("/chat")
    public ChatMessage sendMessage (ChatMessage message) {
        log.info("Received message from '{}': '{}'", message.getSender(), message.getContent());

        return message;
    }
}