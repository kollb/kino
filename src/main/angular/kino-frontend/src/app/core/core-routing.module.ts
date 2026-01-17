import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {NotFoundComponent} from '@core/not-found/not-found.component';

const routes: Routes = [
  {
    path: '',
    pathMatch: 'full',
    redirectTo: 'movie'
  },
  {
    path: 'admin',
    loadChildren: () => import('./../admin/admin.module').then(m => m.AdminModule)
  },
  {
    path: 'account',
    loadChildren: () => import('./../account/account.module').then(m => m.AccountModule)
  },
  {
    path: 'movie',
    loadChildren: () => import('./../movie/movie.module').then(m => m.MovieModule)
  },
  {
    path: 'reservation',
    loadChildren: () => import('./../reservation/reservation.module').then(m => m.ReservationModule)
  },
  {
    path: 'login',
    loadChildren: () => import('./../login/login.module').then(m => m.LoginModule)
  },
  {
    path: '404',
    component: NotFoundComponent
  },
  {
    path: '**',
    pathMatch: 'full',
    redirectTo: '404'
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { enableTracing: false })],
  exports: [RouterModule]
})
export class CoreRoutingModule { }
