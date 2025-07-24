import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';

@Component({
  selector: 'app-chat',
  imports: [],
  templateUrl: './chat.component.html',
  styleUrl: './chat.component.scss'
})
export class ChatComponent implements OnInit {
  sender: string ='';

  constructor(private readonly route: ActivatedRoute) {}

  ngOnInit(): void {
    this.sender = this.route.snapshot.data['sender'] || 'customer';
  }
}
