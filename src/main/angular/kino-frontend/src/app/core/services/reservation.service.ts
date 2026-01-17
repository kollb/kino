import {Injectable, OnDestroy} from '@angular/core';
import {DefaultService} from '@api/api/default.service';
import {Observable, Subject} from 'rxjs';
import {ReservationInfoDto} from '@api/model/reservationInfoDto';
import {map, shareReplay, takeUntil, tap} from 'rxjs/operators';
import {SuccessMessage} from '@api/model/successMessage';
import {ReservationDto} from '@api/model/reservationDto';

@Injectable({
  providedIn: 'root'
})
export class ReservationService implements OnDestroy {

  private myReservations$: Observable<ReservationInfoDto[]>;
  private destroy$ = new Subject<void>();

  constructor(private api: DefaultService) {
    this.refresh();
  }

  refresh() {
    this.myReservations$ = this.api.getMyReservations().pipe(
      takeUntil(this.destroy$),
      shareReplay(1)
    );
  }

  getMyReservations(): Observable<ReservationInfoDto[]> {
    return this.myReservations$;
  }

  getMyReservation(id: number): Observable<ReservationInfoDto> {
    return this.myReservations$.pipe(
      map(reservations => reservations.find(r => r.id === id))
    );
  }

  deleteMyReservation(id: number): Observable<SuccessMessage> {
    return this.api.deleteReservationById(id).pipe(
      tap(() => this.refresh())
    );
  }

  newReservation(dto: ReservationDto): Observable<number> {
    return this.api.newReservation({...dto}).pipe(
      tap(() => this.refresh())
    );
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

}
