import { Routes } from '@angular/router';
import {ChatComponent} from './components/chat/chat.component';

export const routes: Routes = [
  { path: 'customer', component: ChatComponent, data: { sender: 'customer'} },
  { path: 'support', component: ChatComponent, data: { sender: 'support'} },
  { path: '', redirectTo: '/', pathMatch: 'full' }
];
