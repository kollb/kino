import {Injectable, OnDestroy} from '@angular/core';
import {DefaultService} from '@api/api/default.service';
import {CinemaHallDto} from '@api/model/cinemaHallDto';
import {Observable, Subject} from 'rxjs';
import {map, shareReplay, takeUntil} from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class CinemaHallService implements OnDestroy {

  private halls$: Observable<CinemaHallDto[]>;
  private destroy$ = new Subject<void>();

  constructor(private api: DefaultService) {
    this.refresh();
  }

  refresh() {
    this.halls$ = this.api.getAllCinemaHalls().pipe(
      takeUntil(this.destroy$),
      shareReplay(1)
    );
  }

  getCinemaHall(id: number): Observable<CinemaHallDto> {
    return this.halls$.pipe(
      map(halls => halls.find(hall => hall.id === id))
    );
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }
}
