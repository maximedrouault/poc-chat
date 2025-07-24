import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {ChatService} from "../../services/chat.service";
import {ChatMessage} from "../../interfaces/chat-message.interface";
import {FormsModule} from "@angular/forms";
import {UpperCasePipe} from "@angular/common";

@Component({
  selector: 'app-chat',
  imports: [
    FormsModule,
    UpperCasePipe
  ],
  templateUrl: './chat.component.html',
  styleUrl: './chat.component.scss'
})
export class ChatComponent implements OnInit {
  sender: string = '';
  content: string = '';
  chatMessages: ChatMessage[] = [];

  constructor(
      private readonly route: ActivatedRoute,
      private readonly chatService: ChatService
  ) {}

  ngOnInit(): void {
    this.sender = this.route.snapshot.data['sender'] || 'customer';

    this.chatService.watch().subscribe(message => {
      this.chatMessages.push(message);
    });
  }

  send(): void {
    if (this.content.trim()) {
      this.chatService.send(this.sender, this.content);
      this.content = '';
    }
  }
}
