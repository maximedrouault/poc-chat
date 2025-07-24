import { Injectable } from '@angular/core';
import {RxStomp} from '@stomp/rx-stomp';
import {rxStompConfig} from '../config/rx-stomp.config';
import {ChatMessage} from '../interfaces/chat-message.interface';
import {map, Observable} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ChatService {

  private readonly rxStomp: RxStomp = new RxStomp();

  constructor() {
    this.rxStomp.configure(rxStompConfig);
    this.rxStomp.activate();
  }

  watch(): Observable<ChatMessage> {
    return this.rxStomp.watch('/chat').pipe(
      map(msg => JSON.parse(msg.body) as ChatMessage)
    );
  }

  send(sender: string, content: string): void {
    this.rxStomp.publish({
      destination: '/chat.send',
      body: JSON.stringify({sender, content})
    });
  }
}
