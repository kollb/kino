import {Injectable, OnDestroy} from '@angular/core';
import {Observable, Subject} from "rxjs";
import {DefaultService} from "@api/api/default.service";
import {map, shareReplay, takeUntil} from "rxjs/operators";
import {PresentationWithSeatsDto} from "@api/model/presentationWithSeatsDto";

@Injectable({
  providedIn: 'root'
})
export class PresentationService implements OnDestroy {

  private presentations$: Observable<PresentationWithSeatsDto[]>;
  private destroy$ = new Subject<void>();

  constructor(private api: DefaultService) {
    this.refresh();
  }

  refresh() {
    this.presentations$ = this.api.getAllPresentations().pipe(
      takeUntil(this.destroy$),
      shareReplay(1)
    );
  }

  getPresentation(id: number): Observable<PresentationWithSeatsDto> {
    return this.presentations$.pipe(
      map(presentations => presentations.find(p => p.id === id))
    );
  }

  getAllPresentations(): Observable<PresentationWithSeatsDto[]> {
    return this.presentations$;
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

}
