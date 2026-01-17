import {Component, OnInit} from '@angular/core';
import {AuthService} from "@core/auth";

@Component({
  standalone: false,
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  constructor(public auth: AuthService) { }

  ngOnInit() {
  }

}
